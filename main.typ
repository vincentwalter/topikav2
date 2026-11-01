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

#align(center, image("assets/taschenatlas_haut_wirkstoff.jpg"))
#cite(taschenatlas)

== Vehikel
#align(center)[
  #only(1, vehikel(1))
  #only(2, vehikel(2))
  #only(3, vehikel(3))
]
#cite(taschenatlas)

//TODO WAS WO klinische Bilder + Momegalen
== Systematik der Grundlagen
#align(center, image("assets/leitlinie_abbildung3.png", height: 100%))
#cite(leitlinie)

// Abschlussfolie
#end-slide()
