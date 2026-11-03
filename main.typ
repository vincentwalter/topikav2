#import "ukt-talk.typ": *
#import "diagrams.typ": vehikel

#set text(lang: "de")
#set list(marker: "—")
#set table(
  stroke: gray,
  fill: (_, y) => if y == 0 { luma(220) },
  inset: 8pt,
)
#show table.cell: cell => if cell.y == 0 { strong(cell) } else { cell }

#show: ukt-talk.with(
  title: [Topische Therapie / \
    Dermatologische Rezepturen],
  author: [Vincent Walter],
  date: [WS26/27],
  // Optionaler Text neben der Foliennummer, z. B. [Klinik / Abteilung].
  title-or-chapter: none,
  // Handout: Folienbilder neben dem Text (true) oder nur die Handout-Texte (false).
  handout-slides: true,
  // Handout mit Folienbildern: auch Folien ohne Handout-Text aufnehmen.
  handout-all-slides: false,
)

#let taschenatlas = [Röcken M, Schaller M, Sattler E, French L, Hrsg. Taschenatlas Dermatologie. Thieme; 2024.]
#let leitlinie = [Wohlrab J, et al. S2k-Leitlinie Topika. AWMF-Register-Nr. 013-092; 2017. Abb. 3.]

// Titelfolie
#title-slide(
  background: "assets/title-bg.jpeg",
  title_size: 44pt,
  title_strip_width: 65%,
)
#notes[Begrüßung, kurz vorstellen. Ziel des Vortrags in einem Satz.]

= Was möchtet ihr lernen?

= Warum topische Therapie?

== Vorteile gegenüber systemischer Therapie
- Direkte Wirkung am Zielorgan (z.B. Haut)
- Reduzierte systemische Nebenwirkungen
- Hohe lokale Wirkstoffkonzentrationen
- *Flexible Galenik* - an den Hautzustand anpassbar.

= Grundlagen

#slide(title: [Grundlagen], section: none)[
  #align(center, image("assets/taschenatlas_haut_wirkstoff.jpg"))
  #cite(taschenatlas)
]

== Vehikel
#align(center)[
  #only(1, vehikel(1))
  #only(2, vehikel(2))
  #only(3, vehikel(3))
]
#cite(taschenatlas)

== Warum unterschiedliche Vehikel?
#align(center + horizon, grid(
  columns: 2,
  gutter: 2pt,
  image("assets/akut.JPG"),
  image("assets/chronisch.JPG"),
))

== Warum unterschiedliche Vehikel?
#align(center + horizon, grid(
  columns: 3,
  gutter: 2pt,
  image("assets/haar.JPG"),
  image("assets/interdigital.JPG"),
  image("assets/penis.JPG"),
))

== Warum unterschiedliche Vehikel?
#layout(size => {
  // Nagelbild auf Hochformat (2:3) zuschneiden, Mittelfinger (x ≈ 45 %) zentriert.
  let h = size.height
  let w = h * 2 / 3
  align(center + horizon, grid(
    columns: 3,
    gutter: 2pt,
    box(width: w, height: h, clip: true, align(left + top, move(
      dx: w / 2 - 0.45 * h * 3 / 2,
      image("assets/nägel.JPG", width: h * 3 / 2, height: h),
    ))),
    image("assets/pso_ohr.JPG", height: h),
    image("assets/rosacea.JPG", height: h),
  ))
})

== Beispiel Momegalen (Mometason)
#align(center+horizon, image("assets/momegalen.png"))



== Systematik der Grundlagen
#align(center, image("assets/leitlinie_abbildung3.png", height: 100%))
#cite(leitlinie)

// Abschlussfolie
#end-slide()
