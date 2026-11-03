// Single-source wrapper around ukt-theme.typ.
//
// One source file (main.typ) is compiled in different modes:
//
//   typst compile main.typ                        -> slides (with animations)
//   typst compile --input mode=thumbs main.typ    -> slides, one page per slide
//   typst compile --input mode=handout main.typ   -> A4 handout
//   typst compile --input mode=script main.typ    -> A4 speaker script
//
// Handout and script embed pages of the `thumbs` PDF. Which page belongs to
// which #notes/#handout block is read from a JSON map that compile.sh
// extracts from the `thumbs` build (see `thumbs-map`).

#import "@preview/touying:0.8.0": *
#import "ukt-theme.typ" as theme: ukt-blue, ukt-gold, ukt-text, card, cite

#let mode = sys.inputs.at("mode", default: "slides")
#assert(
  mode in ("slides", "thumbs", "handout", "script"),
  message: "unknown mode: " + mode,
)
#let _is-doc = mode in ("handout", "script")

#let _thumbs-pdf = sys.inputs.at("thumbs", default: "/build/thumbs.pdf")
#let _thumbs-map = sys.inputs.at("map", default: "/build/thumbs.json")

// `--input handout-slides=true|false` overrides the `handout-slides` setting.
#let _handout-slides-input = sys.inputs.at("handout-slides", default: none)
#assert(
  _handout-slides-input in (none, "true", "false"),
  message: "handout-slides must be true or false",
)

// Called by compile.sh via `typst eval --in main.typ --input mode=thumbs`.
// Returns the total page count and, in source order, the kind and page of
// every #notes/#handout block. Touying records each note as pdfpc metadata
// on the page it belongs to, which is what makes this mapping exact.
#let thumbs-map() = (
  pages: query(<pdfpc>).filter(m => m.value.t == "NewSlide").len(),
  asides: query(<pdfpc>)
    .filter(m => m.value.t == "Note" and m.value.v.starts-with("ukt:"))
    .map(m => (kind: m.value.v.slice(4), page: m.location().page())),
)

// ---- Authoring helpers ------------------------------------------------------

#let _aside(kind, body) = if mode == "slides" {
  if kind == "notes" { speaker-note(subslide: none, body) }
} else if mode == "thumbs" {
  // A marker note, so that its page can be looked up afterwards.
  speaker-note(subslide: none, "ukt:" + kind)
} else {
  [#metadata((kind: kind, body: body))<ukt-aside>]
}

/// Presenter notes: pdfpc notes on the slides, main text of the script.
#let notes(body) = _aside("notes", body)

/// Handout text for the current slide. Not shown on the slides.
#let handout(body) = _aside("handout", body)

// ---- Slide functions --------------------------------------------------------
//
// In the document modes the slides themselves are not rendered; slide bodies
// still have to be evaluated so that the #notes/#handout blocks inside them
// are found in the same order as in the slide build.

#let title-slide(..args) = if not _is-doc { theme.title-slide(..args) }
#let section-slide(..args) = if not _is-doc { theme.section-slide(..args) }
#let end-slide(..args) = if not _is-doc { theme.end-slide(..args) }
#let black-slide(..args) = if not _is-doc { theme.black-slide(..args) }
#let slide(..args) = if _is-doc { args.pos().join() } else {
  theme.slide(..args)
}

// ---- Companion documents (handout and script) -------------------------------

#let _companion(
  title: none,
  author: none,
  date: none,
  all-slides: false,
  with-slides: true,
  body,
) = {
  let kind = if mode == "script" { "notes" } else { "handout" }

  set page(
    paper: "a4",
    margin: (x: 18mm, top: 24mm, bottom: 20mm),
    header: context if here().page() > 1 {
      set text(size: 9pt, fill: ukt-blue)
      title
      h(1fr)
      if mode == "script" [Sprechzettel] else [Handout]
      v(-6pt)
      line(length: 100%, stroke: 0.6pt + ukt-gold)
    },
    footer: context {
      set text(size: 9pt, fill: ukt-text)
      h(1fr)
      counter(page).display("1 / 1", both: true)
    },
  )
  set text(font: ("Calibri", "Carlito", "Helvetica Neue", "Arial"))
  set text(size: if mode == "script" { 12pt } else { 10.5pt }, fill: ukt-text)
  set par(justify: true)
  show heading: set text(fill: ukt-blue)

  // The slide content is evaluated but not shown; only the asides are used.
  place(hide(body))

  // Title block
  block(width: 100%, inset: (bottom: 6mm), stroke: (bottom: 1.5pt + ukt-gold), {
    text(size: 22pt, weight: "bold", fill: ukt-blue, title)
    if mode == "script" { text(size: 22pt, fill: ukt-blue)[ -- Sprechzettel] }
    v(2mm)
    text(weight: "bold", author)
    if date != none [ · #date]
  })
  v(4mm)

  // Text only: the blocks in source order, no slide images. This needs
  // neither the thumbs PDF nor the page map.
  if not with-slides {
    context query(<ukt-aside>)
      .filter(a => a.value.kind == kind)
      .map(a => a.value.body)
      .join(parbreak())
    return
  }

  let map = json(_thumbs-map)
  context {
    // Pair blocks of one kind in source order with their pages. (Order across
    // kinds can differ within a slide, but never across slides.)
    let asides = query(<ukt-aside>).filter(a => a.value.kind == kind)
    let places = map.asides.filter(m => m.kind == kind)
    assert(
      asides.len() == places.len(),
      message: "build/thumbs.json is out of date, rerun compile.sh",
    )
    // page number -> combined body of all blocks on that page
    let by-page = (:)
    for (a, m) in asides.zip(places) {
      let key = str(m.page)
      let prev = by-page.at(key, default: none)
      by-page.insert(key, if prev == none { a.value.body } else {
        prev + parbreak() + a.value.body
      })
    }
    let pages = if all-slides or mode == "script" {
      range(1, map.pages + 1)
    } else {
      by-page.keys().map(int).sorted()
    }
    for p in pages {
      block(breakable: true, below: 7mm, grid(
        columns: (78mm, 1fr),
        column-gutter: 6mm,
        box(stroke: 0.5pt + luma(180), image(_thumbs-pdf, page: p)),
        by-page.at(str(p), default: none),
      ))
    }
  }
}

// ---- Entry point ------------------------------------------------------------

#let ukt-talk(
  title: none,
  author: none,
  date: none,
  title-or-chapter: none,
  // Handout only: show slide images next to the text. With `false`, the
  // handout contains just the #handout blocks.
  handout-slides: true,
  // Handout only: also list slides without handout text.
  handout-all-slides: false,
  ..args,
  body,
) = {
  if _is-doc {
    _companion(
      title: title,
      author: author,
      date: date,
      all-slides: handout-all-slides,
      with-slides: mode == "script" or if _handout-slides-input == none {
        handout-slides
      } else { _handout-slides-input == "true" },
      body,
    )
  } else {
    show: theme.ukt-theme.with(
      config-info(title: title, author: author, date: date),
      config-common(handout: mode == "thumbs"),
      title-or-chapter: title-or-chapter,
      ..args,
    )
    body
  }
}
