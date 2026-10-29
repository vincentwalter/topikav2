#import "@preview/touying:0.7.3": *

// UKT corporate color palette (from theme3.xml clrScheme "UKT_blau")
#let ukt-blue = rgb("#454B6A") // tx2 / dk2
#let ukt-gold = rgb("#BAA874") // bg2 / lt2
#let ukt-text = rgb("#3C3C41") // tx1 / dk1

// Canvas: Typst's `presentation-16-9` paper preset (297mm × 167mm).
// All chrome positions below are expressed as fractions of the slide width
// or height, lifted from the source pptx and converted from EMU. Because
// the aspect ratio matches the pptx (1.778), the proportional layout is
// pixel-equivalent to the original at this smaller canvas.

// ---- Shared full-bleed accents (placed via config-page(background:)) -------

#let _bg-gold-strip = place(
  top + left,
  dy: 98.15%,
  rect(width: 100%, height: 1.85%, fill: ukt-gold),
)

#let _bg-logo-color(path) = place(
  top + left,
  dx: 70.70%,
  dy: 77.80%,
  image(path, width: 28.29%, height: 20.35%),
)

#let _bg-logo-icon(path) = place(
  top + left,
  dx: 90.76%,
  dy: 88.89%,
  image(path, width: 7.43%, height: 9.26%),
)

#let _bg-date-block(d) = place(
  top + left,
  dx: 3.14%,
  dy: 92.46%,
  block(
    width: 22.50%,
    height: 1.92%,
    inset: 0pt,
    text(size: 12pt, fill: ukt-text, d),
  ),
)

#let _bg-author-block(a) = place(
  top + left,
  dx: 3.14%,
  dy: 82.5%,
  block(
    width: 22.50%,
    height: 1.92%,
    inset: 0pt,
    text(size: 12pt, weight: "bold", fill: ukt-text, a),
  ),
)

#let _bg-copyright(c) = place(
  top + left,
  dx: 3.14%,
  dy: 96.30%,
  block(
    width: 29.39%,
    height: 1.84%,
    inset: 0pt,
    text(size: 6pt, fill: ukt-text, c),
  ),
)

#let cite(c) = place(
  top + left,
  dx: 10%,
  dy: 103%,
  block(
    width: 83%,
    height: 10%,
    align(horizon + right, text(size: 12pt, fill: ukt-text, c)),
  ),
)

#let card(
  stroke: gray,
  fill: luma(220),
  inset: 6pt,
  title: [Titel],
  title_alignment: center + horizon,
  rows: (36pt, 1fr),
  content,
) = {
  grid(
    rows: rows,
    box(width: 100%, height: 100%, stroke: stroke, fill: fill, align(title_alignment, title)),
    box(width: 100%, height: 100%, stroke: stroke, inset: inset, content),
  )
}

// ---- Footer used by content + section slides ------------------------------
//
// Touying renders the footer in the bottom margin with width equal to the
// body width (page-width minus left/right margins). Touying's `place` calls
// inside `footer` resolve percentages against the footer box, so we use
// absolute mm offsets that match the pptx page-number / chapter caption.

#let _content-footer(self, fill: ukt-gold) = {
  let s = self.store
  set text(size: 16pt, fill: fill, weight: "regular")
  // Page-number block (5.25% × 5.32% of slide ≈ 15.6mm × 8.9mm)
  box(
    width: 15.6mm,
    height: 8.9mm,
    inset: (x: 2.2mm, y: 1.1mm),
    align(center + horizon, context utils.slide-counter.display()),
  )
  if s.title-or-chapter != none {
    h(2mm)
    text(weight: "bold", s.title-or-chapter)
  }
}

// ============================================================================
// 1) Title slide  — Layout 65 (01_A_Titelfolie)
// ============================================================================

#let title-slide(
  config: (:),
  title: none,
  date: none,
  author: none,
  background: none,
  title_size: 48pt,
  title_strip_width: 48.44%,
) = touying-slide-wrapper(self => {
  let info = self.info
  let s = self.store
  let _title = if title != none { title } else { info.title }
  let _author = if author != none { author } else { info.author }
  let _date = if date != none { date } else { info.date }

  let bg = {
    if background != none {
      place(top + left, image(background, width: 100%, height: 77.80%))
    }
    _bg-gold-strip
    _bg-logo-color(s.logo-color)
    if _author != none { _bg-author-block(_author) }
    if _date != none { _bg-date-block(_date) }
    _bg-copyright(s.copyright)
  }

  let body = {
    // Translucent dark-blue title band, descending from the photo
    place(
      top + left,
      dx: 0pt,
      dy: 41.85%,
      block(
        width: title_strip_width,
        fill: ukt-blue.transparentize(30%),
        inset: (left: 10.5mm, right: 4.0mm, top: 7.0mm, bottom: 4.0mm),
        text(size: title_size, weight: "bold", fill: ukt-gold, _title),
      ),
    )
  }

  let new-self = utils.merge-dicts(
    self,
    config-page(
      paper: "presentation-16-9",
      margin: 0pt,
      header: none,
      footer: none,
      background: bg,
      fill: white,
    ),
  )
  touying-slide(self: new-self, config: config, body)
})

// ============================================================================
// 2) Content slide — Layout 66 (01_X_Inhaltsfolie)
// ============================================================================

#let slide(
  config: (:),
  title: auto,
  section: none,
  ..args,
) = touying-slide-wrapper(self => {
  let s = self.store

  let _title = if title == auto {
    utils.display-current-heading(level: 2)
  } else if title == none {
    []
  } else { title }

  // When a section title is given, the header band grows to host both the
  // small section caption (top) and the larger slide title (below), mirroring
  // the touying "build your own theme" example. Without a section, the
  // original single-title band is preserved verbatim.
  let has-section = section != none
  let band-height = 15% // if has-section { 22% } else { 15% }
  let top-margin = 18% // if has-section { 25% } else { 18% }

  // Background: full-bleed dark-blue header band, gold accent strip, logo icon
  let bg = {
    place(top + left, rect(width: 100%, height: band-height, fill: ukt-blue))
    _bg-gold-strip
    _bg-logo-icon(s.logo-icon-color)
  }

  // Header: gold title text, vertically centered within the blue band.
  // The band lives in the background; the header just paints text over it.
  // The bottom pad equals the gap between the band and the top margin so the
  // text centres inside the coloured band rather than the whole margin area.
  let header-content = pad(
    top: 0pt,
    bottom: (top-margin - band-height) / top-margin * 100%,
    box(
      width: 100%,
      height: 100%,
      inset: (left: 3%, right: 3%),
      align(
        horizon + left,
        if has-section {
          stack(
            dir: ttb,
            spacing: 10pt,
            text(size: 18pt, weight: "regular", fill: ukt-gold, section),
            text(size: 33pt, weight: "bold", fill: ukt-gold, _title),
          )
        } else {
          text(size: 33pt, weight: "bold", fill: ukt-gold, _title)
        },
      ),
    ),
  )

  let footer-content = _content-footer(self, fill: ukt-gold)

  let chrome = body => {
    set text(size: 24pt, fill: ukt-text)
    body
  }

  let new-self = utils.merge-dicts(
    self,
    config-page(
      paper: "presentation-16-9",
      margin: (top: top-margin, bottom: 12%, left: 3%, right: 3%),
      header: header-content,
      footer: footer-content,
      header-ascent: 0pt,
      footer-descent: 8mm,
      background: bg,
      fill: white,
    ),
  )
  touying-slide(self: new-self, config: config, setting: chrome, ..args)
})

// ============================================================================
// 3) Section slide — Layout 89 (06_A_Kapiteltrenner)
// ============================================================================

#let section-slide(
  config: (:),
  title: auto,
  subtitle: none,
  ..args,
) = touying-slide-wrapper(self => {
  let s = self.store

  let _title = if title == auto {
    utils.display-current-heading(level: 1)
  } else if title == none {
    []
  } else { title }

  let bg = {
    // Full-bleed dark blue (covers everything except the gold strip)
    place(top + left, rect(width: 100%, height: 98.15%, fill: ukt-blue))
    _bg-gold-strip
    _bg-logo-icon(s.logo-icon-white)
  }

  let footer-content = _content-footer(self, fill: white)

  let body = {
    // Big gold title in upper third
    place(
      top + left,
      dx: 0pt,
      dy: 12.99%,
      block(
        width: 48.44%,
        inset: (left: 10.5mm, right: 4.0mm, top: 7.0mm, bottom: 4.0mm),
        text(size: 48pt, weight: "bold", fill: ukt-gold, _title),
      ),
    )
    if subtitle != none {
      place(
        top + left,
        dx: 0pt,
        dy: 61.14%,
        block(
          width: 36.27%,
          inset: (left: 10.5mm, right: 10.0mm, top: 4.0mm, bottom: 4.0mm),
          text(size: 28pt, weight: "bold", fill: ukt-gold, subtitle),
        ),
      )
    }
  }

  let new-self = utils.merge-dicts(
    self,
    config-page(
      paper: "presentation-16-9",
      margin: (top: 0pt, bottom: 12%, left: 3%, right: 3%),
      header: none,
      footer: footer-content,
      footer-descent: 8mm,
      background: bg,
      fill: white,
    ),
  )
  touying-slide(self: new-self, config: config, body)
})

// ============================================================================
// 4) Closing slide — Layout 92 (07_A_Abschlussfolie)
// ============================================================================

#let end-slide(
  config: (:),
  title: [Vielen Dank für\ Ihre Aufmerksamkeit],
  date: none,
) = touying-slide-wrapper(self => {
  let info = self.info
  let s = self.store
  let _date = if date != none { date } else { info.date }

  let bg = {
    place(top + left, rect(width: 100%, height: 77.80%, fill: ukt-blue))
    _bg-gold-strip
    _bg-logo-color(s.logo-color)
    if _date != none { _bg-date-block(_date) }
    _bg-copyright(s.copyright)
  }

  let body = {
    place(
      top + left,
      dx: 3.07%,
      dy: 45.45%,
      block(
        width: 75%,
        inset: 0pt,
        {
          // Match PowerPoint's tight lnSpc=5000 (50pt) line spacing for 48pt text.
          set par(leading: 24pt)
          set text(size: 48pt, weight: "bold", fill: ukt-gold)
          title
        },
      ),
    )
  }

  let new-self = utils.merge-dicts(
    self,
    config-page(
      paper: "presentation-16-9",
      margin: 0pt,
      header: none,
      footer: none,
      background: bg,
      fill: white,
    ),
  )
  touying-slide(self: new-self, config: config, body)
})

// ============================================================================
// Theme registration
// ============================================================================

#let ukt-theme(
  aspect-ratio: "16-9",
  logo-color: "assets/logo-color.png",
  logo-icon-color: "assets/logo-icon-color.png",
  logo-icon-white: "assets/logo-icon-white.png",
  copyright: [© UNIVERSITÄTSKLINIKUM TÜBINGEN.],
  title-or-chapter: none,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: 0pt,
      fill: white,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: section-slide,
    ),
    config-colors(
      primary: ukt-blue,
      secondary: ukt-gold,
      neutral-darkest: ukt-text,
      neutral-lightest: white,
    ),
    config-store(
      logo-color: logo-color,
      logo-icon-color: logo-icon-color,
      logo-icon-white: logo-icon-white,
      copyright: copyright,
      title-or-chapter: title-or-chapter,
    ),
    ..args,
  )
  set text(font: ("Calibri", "Carlito", "Helvetica Neue", "Arial"), size: 18pt, fill: ukt-text)
  body
}
