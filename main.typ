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
#let leitlinie-tab1 = [Wohlrab J, et al. S2k-Leitlinie Topika. AWMF-Register-Nr. 013-092; 2017. Tab. 1.]

// Tabelle 1 der Leitlinie: (Indikation, Rezepturvorschläge)
#let magistral-links = (
  ([Verruca vulgaris], ([Dithranolhaltige Warzensalbe (NRF 11.31)],)),
  ([Touchieren von hypergranulierte Wunden], ([Silbernitratlösung 10% (NRF 11.99.)],)),
  ([Chronisches Handekzem, \ Psoriasis palmaris et plantaris], ([Hydrophile LCD-Creme 5/10/20% (NRF 11.86.)],)),
  ([Psoriasis capitis], (
    [Abwaschbares Salizylsäure-Öl 2-10% (NRF 11.85)],
    [Abwaschbares Salizylsäure-Öl 2-10% mit Triamcinolonacetonid 0,1% (NRF 11.140.)],
    [Viskose Tensidlösung mit Steinkohlenteerspiritus 5/10% (NRF11.143.)],
    [Fettender Salicylsäure-Hautspiritus 1/2/3/5% (NRF 11.145).],
  )),
  ([Pityriasis simplex capitis], ([Selendisulfid-Waschgel 2,5% (NRF 11.139.)],)),
  ([subakutes Ekzem], (
    [Hydrophile Prednicarbatcreme 0,08/0,15/0,25% (NRF 11.144.)],
    [Lipophile Ammoniumbituminosulfonat-Creme 5-20% NRF 11.12.],
  )),
  ([Superinfiziertes Ekzem], (
    [Hydrophile Prednicarbatcreme 0,08/0,15/0,25% mit Octenidindihydrochlorid 0,1% (NRF 11.145.)],
    [Hydrophile Triamcinolonacetonid-Creme 0,025/0,05/0,1 % mit Chlorhexidindigluconat 1 % NRF 11.136.)],
  )),
  ([chronisches Ekzem mit Juckreiz, \ Prurigo simplex subacuta], (
    [Lipophile Polidocanol-Creme 5% (NRF 11.119.) mit Harnstoff 5% (NRF 11.120.)],
    [Mometasonfuroat 0,1% in hydrophilem Zinkoxid-Liniment 25% (NRF 11.109)],
    [Mometasonfuroat 0,1% in weicher Zinkpaste DAB],
  )),
)

#let magistral-rechts = (
  ([Intertriginöse Candidiasis], ([Zinkoxid-Neutralöl 50% mit Nystatin 70.000 IE/g (NRF 11.114.)],)),
  ([Erysipel (feuchte Umschläge)], ([Polihexanid-Lösung 0,02/0,04% (NRF 11.128.)],)),
  ([Psoriasis vulgaris, \ Mycosis fungoides], ([Methoxsalen-Badekonzentrat 5mg/ml (NRF 11.83.)],)),
  ([Psoriasis vulgaris, \ Alopezia areata], (
    [Abwaschbare Dithranol-Salbe 0,05-2% ggf mit Salizylsäure 2% (NRF 11.52.)],
    [Dithranol-Vaselin 0,05-2% ggf. mit Salizylsäure (NRF 11.51)],
    [Weiche Dithranol-Zinkpaste 0,05-2% (NRF 11.56)],
  )),
  ([Bullöses Pemphigoid], ([Hydrophile Clobetasolpropionat-Creme 0,05% (NRF 11.76.)],)),
  ([Chronischer Pruritus, \ Prurigo simplex subacuta], (
    [Kühlcreme DAB (Unguentum leniens) (früher: Kühlsalbe)],
    [Hydrophile Capsaicinoid-Creme 0,025/0,05/0,1% (NRF 11.125.)],
    [sogen. 1-2-3-Creme: Chloralhydrat 3,0 g, D-Campher oder racematischer Campher 2,0 g, Levomenthol 1,0 g, Basiscreme DAC ad 100,0 g],
  )),
  ([Verhornungsstörungen], (
    [Hydrophile Tretinoin-Creme 0,025-0,1% (NRF 11.100.)],
    [Lipophile Tretinoin-Creme 0,025-0,1% (NRF 11.123.)],
    [Lipophile Tretinoin-Salbe 0,025-0,1% (NRF 11.101.)],
    [Lipophile Harnstoff-Natriumchlorid-Salbe NRF 11.75.],
  )),
  ([Mundschleimhaut\-entzündungen], (
    [Betamethasovalerat Haftpaste 0,1% (NRF 7.11.)],
    [Hydrocortisonacetat-Suspension 0,5% mit Lidocain HCl und Dexpanthenol NRF (11.14.)],
    [Polihexanid-Mundwasser 0,12% (NRF 7.12.)],
    [Tormentill-Myrrhe-Adstringens (NRF 7.1.)],
    [Ratanhia-Myrrhe-Adstringens (NRF 7.1.)],
    [Tretinoin-Haftpaste 0,05/0,1% (NRF 7.9.)],
  )),
)

#let magistral-tabelle(rows) = {
  set text(size: 10pt)
  set table(inset: (x: 5pt, y: 3.5pt))
  table(
    columns: (32%, 68%),
    table.header([Indikation], [Rezepturvorschlag]),
    ..rows
      .map(r => (r.at(0), r.at(1).join(parbreak())))
      .flatten(),
  )
}

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

== Beispiel Momegalen (Mometason)
#align(center+horizon, image("assets/momegalen.png"))

#black-slide()

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

== Warum unterschiedliche Vehikel?
#align(center + horizon, grid(
  columns: 2,
  gutter: 2pt,
  image("assets/atopie_alt.JPG"),
  image("assets/atopie_jung.JPG"),
))

#black-slide()

== Systematik der Grundlagen
#align(center, image("assets/leitlinie_abbildung3.png", height: 100%))
#cite(leitlinie)


#slide(title: [Lokalisation beeinflusst Wirkstärke])[
  #grid(
    columns: 3,
    column-gutter: 6pt,
    card(title: [Besondere Empfindlichkeit], rows: (1fr, 4fr))[
      - Männliches Genitale (besonders Skrotum) //Skrotum 42x Aufnahme von Hydrocortison im Vergleich zum Unterarm
      - Hals
      - Intertrigines
      - Gesicht
      #v(1fr)
    ],
    card(title: [Geringe Empfindlichkeit], rows: (1fr, 4fr))[
      - Handflächen
      - Fußsohlen
      - Kapillitium
      #v(1fr)
    ],
    card(title: [Mittlere Empfindlichkeit], rows: (1fr, 4fr))[
      - Restlicher Körper
      #v(1fr)
    ],
  )
]

#slide(title: [Penetration & Einflussfaktoren])[
  Einflussfaktoren auf die Wirkstoffaufnahme:

  - *Vehikel:* Lipophile Grundlagen fördern Penetration ins Stratum corneum
  - *Okklusion:* Steigert Hauthydratation → erhöhte Permeabilität
  - *Hautzustand:* Vorgeschädigte / entzündete Haut → erhöhte Aufnahme
  - *Lokalisation:* Skrotum, Gesicht › Unterarm › Handrücken › Fußsohle
  - *Alter:* Topika wirken bei Kindern stärker
  - *Compliance:* Angenehmes wird appliziert, unangenehmes eher nicht
]

#slide(title: [Mengenberechnung])[
  #grid(
    columns: (1fr, 1fr),
    [
      - 1 Handinnenfläche + Finger = 1% KOF
      - 1% KOF benötigt 0,25g Topikum
      - 1/2 Fingerspitze = 0,25g Topikum => 1 Fingerspitze reicht für 2% KOF
    ],
    align(center + horizon, image("assets/kof.JPG")),
  )
]


// ─── Rezeptur vs Fertigprodukt ────────────────────────────────────────────────

#slide(title: [Rezepturen])[
  #set par(justify: true)
  #grid(
    columns: 2,
    column-gutter: 6pt,
    card(title: [Magistralrezeptur])[
      - Standardisierte, auf Plausibilität geprüfte, offizielle Rezepturen
      - Neues Rezeptur Formularium [NRF]
      - Deutsches Arzneibuch [DAB]
      - Deutscher Arzneimittel Codex [DAC]
    ],
    card(title: [Individualrezeptur])[
      - frei zusammengestellt
      - auf spezielle Patientenbedürfnisse abgestimmt
      - wird von der Apotheke geprüft
    ],
  )
]

#slide(title: [Rezepturen])[
  *Wann sinnvoll?*
  #pause
  - Spezielle Wirkstoffkonzentrationen nicht als Fertigarzneimittel verfügbar
  - Kombinationspräparate fehlen am Markt
  - Kinderdermatologie (altersgerechte Dosierungen)
  - Unverträglichkeit bestimmter Hilfsstoffe (Kontaktallergene)
  - Seltene Indikationen
  - Manchmal deutlich günstiger
]

#slide(title: [Magistralrezepturen: Beispiele])[
  #set par(spacing: 0.45em, leading: 0.4em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 8pt,
    magistral-tabelle(magistral-links),
    magistral-tabelle(magistral-rechts),
  )
  #cite(leitlinie-tab1)
]

#slide(title: [Rezepturen: Nicht nur Topika])[
  #grid(
    columns: (1fr, 1.2fr),
    column-gutter: 6pt,
    image("assets/darier.JPG", width: 100%, height: 100%, fit: "cover"),
    grid(
      rows: (auto, 1fr),
      row-gutter: 6pt,
      block(
        fill: rgb(247, 223, 223),
        inset: (x: 1em, y: 0.8em),
        radius: 4pt,
        width: 100%,
        [
          #set text(16pt)
          120 Naltrexon-Hydrochlorid 5mg Kps\
          Füllstoff: Mannitol 99,5T /Siliciumdioxid 0,5T

          1x täglich
        ],
      ),
      block(
        fill: rgb(247, 223, 223),
        inset: (x: 1em, y: 0.8em),
        radius: 4pt,
        width: 100%,
        height: 100%,
        [
          #set text(16pt)
          Naltrexon-HCl 5mg/ml
          #table(
            columns: 2,
            fill: none,
            stroke: none,
            [Naltrexonhydrochlorid], [0,5g],
            [Ascorbinsäure], [0,5g],
            [Natriumbenzoat], [0,1g],
            [Glycerin 85%], [20ml],
            [Aqua purificata], [ad 100,0g],
          )
          1x tgl 1ml
        ],
      ),
    ),
  )
]

= Topische Kortikosteroide
#slide(title: [Topische Kortikosteroide], section: none)[
  #grid(
    columns: (3fr, 1fr),
    gutter: 12pt,
    align(center, image(height: 100%, "assets/cs_wirkung.jpg")), align(bottom, box(text(18pt, taschenatlas))),
  )
]

== Klassifikation nach Niedner (Klassen I–IV)
#grid(
  columns: 4,
  gutter: 12pt,
  card(title: [Klasse I\ (milde)], rows: (60pt, 1fr), text(18pt)[
    - Dexamethason (0,02-0,05%)
    - Clobetasonbutyrat (0,05%)
    - *Hydrocortison (0,25-1,0%)*
    - Hydrocortisonacetat (0,25-1,0%)
    - Prednisolon (0,4-0,5%)
  ]),
  card(title: [Klasse II\ (mäßig stark)], rows: (60pt, 1fr), text(11.5pt)[
    - Alclometasondipropionat (0,05%)
    - Betamethason-valerat (0,05%)
    - Desoximetason (0,05%)
    - Flumetason (0,02%)
    - Flumetason-pivalat (0,02%)
    - Fluocortolon (0,25%)
    - Flupredniden-21-acetat (0,1-0,25%)
    - Hydrocortison-17-butyrat (0,1%)
    - Hydrocortisonaceponat (0,1%)
    - Hydrocortisonbuteprat (0,1%)
    - *Methylprednisolonaceponat (0,1%)*
    - Prednicarbat (0,25%)
    - Triamcinolonacetonid (0,05-0,1%)
    - Dexamethason (0,1%)
  ]),
  card(title: [Klasse III\ (stark)], rows: (60pt, 1fr), text(14pt)[
    - Amcinonid (0,1%)
    - Betamethason-17,21-dipropionat (0,05%)
    - Betamethason-17-valerat (0,1%)
    - Desoximetason (0,25%)
    - Diflorason-diacetat (0,05%)
    - Diflucortolon-21-valerat (0,1%)
    - Fluocinolonacetonid (0,025-0,1%)
    - Fluticason-propionat (0,025-0,1%)
    - *Mometason-furoat (0,1%)*
  ]),
  card(title: [Klasse IV\ (sehr stark)], rows: (60pt, 1fr), text(18pt)[
    - *Clobetasol-propionat (0,05%)*
    - Diflucortolon-valerat (0,3%)
  ]),
)

== Der therapeutische Index hilft bei der Wirkstoffwahl
#grid(
  rows: (1fr, 12pt),
  table(
    columns: (1fr, 8fr, 2fr, 2fr),
    [], [Effekt], [Wert], [Faktor],
    table.cell(rowspan: 2, rotate(270deg, reflow: true)[Erwünscht]), [Vasokonstriktion], [0-3], [4],
    [Wirksamkeit bei atopischer Dermatitis im Vergleich mehrerer Glukokortikoide], [0-3], [5],
    table.cell(rowspan: 3, rotate(270deg, reflow: true)[Unerwünscht]), [Hautatrophie], [0-3], [6],
    [Hypophysen-Nebennierenrinden-Achse], [0-3], [2],
    [Allergenes Potential], [0-3], [1],
  ),
  grid.cell(align(bottom, text(
    12pt,
  )[Luger T et al., Topische Dermatotherapie mit Glukokortikoiden--Therapeutischer Index. J Dtsch Dermatol Ges. 2004.])),
)

#let tix = csv("assets/tix.tsv", delimiter: "\t")
#slide(title: [Der therapeutische Index hilft bei der Wirkstoffwahl])[
  #align(center, table(
    columns: 3, align: left,
    ..tix.at(0).map(x => strong(x)),
    ..tix.slice(1).flatten()
  ))
]

== Nebenwirkungen
*Lokal:*
- Hautatrophie, Teleangiektasien, Striae distensae
- Steroidakne, periorale Dermatitis
- Rosazea-artige Reaktionen

#v(0.5em)
*Systemisch* (sehr selten, bei großflächiger / langfristiger Anwendung):
- Hypophysen-Nebennierenrinden-Achsen-Suppression
- Cushingoides Syndrom

#v(0.5em)
*Angst vor topischen Steroiden:* Häufig bei Patienten → Bei richtiger Anwendung unbegründet. Rationale Aufklärung ist essenziell.


== Hypophysen-Nebennierenrinden-Achsen-Suppression
#grid(
  columns: (1fr, 1fr),
  image("assets/intern.png"), image("assets/extern.png"),
)

== Nebenwirkungen
  #image("assets/atrophie.JPG")

== Nebenwirkungen
#align(center + horizon, image("assets/pod.JPG"))


== Therapieprinzipien
- Auswahl nach Körperregion, Patientenalter und Behandlungsdauer
- Beginn mit einem starken Steroid
- Ausschleichen
- Stratum corneum bildet ein Reservoir. 1x täglich reicht
- Gesteigerte Wirkung und Nebenwirkungen durch okklusive Applikation

= Calcineurininhibitoren
== Wirkung
#grid(
  columns: (3fr, 1fr),
  gutter: 12pt,
  align(center, image(height: 100%, "assets/calcineurin_wirkung.jpg")),
  align(bottom, box(text(18pt, taschenatlas))),
)

== Wirkstoffe & Indikationen
*Tacrolimus (Protopic / Takrozem / Sumilor):*
- 0,03 % Salbe – Kinder ab 2 Jahren - Atopische Dermatitis
- 0,1 % Salbe – Erwachsene - Atopische Dermatitis
- 0,1% Emulsion - Erwachsene - Psoriasis

#v(0.5em)
*Pimecrolimus (Elidel):*
- 1 % Creme – leichte bis moderate AD (Kinder ab 2 J.)
- Besonders geeignet: Gesicht/Hals

// ─── JAKi ──────────────────────────────────────────────────────────────────────

= JAK-Inhibitoren
== Wirkmechanismus
#grid(
  columns: (3fr, 1fr),
  gutter: 12pt,
  align(center, image(height: 100%, "assets/jaki_wirkung.jpg")), align(bottom, box(text(18pt, taschenatlas))),
)

== Topische JAK-Inhibitoren im Überblick
#grid(
  columns: 2,
  [
    *Ruxolitinib 1,5 % (Opzelura):*
    - Selektiver JAK1/JAK2-Inhibitor
    - Zugelassen: nichtsegmentale Vitiligo mit Beteiligung des Gesichts
    - bei Erwachsenen und Jugendlichen im Alter ab 12 Jahren
    - 100g = 959,56 €
  ],
  image("assets/opzelura.png"),
)
#align(bottom + right, text(14pt)[Bildquelle Incyte])
#pagebreak()
#grid(
  columns: (1fr, 1fr),
  column-gutter: 12pt,
  [
    *Delgocitinib 2 % (Anzupgo):*
    - Pan-JAK-Inhibitor
    - Zulassung: mittelschweres bis schweres chronisches Handekzem bei Erwachsenen, bei denen topische Kortikosteroide nicht ausreichen oder nicht geeignet sind
    - 60g = 662,44€

    #v(1fr)
    #text(14pt)[Bildquelle LEO]
  ],
  grid(
    columns: (2fr, 10fr),
    rows: (1fr, 1fr),
    box(height: 100%, width: 100%, fill: luma(220), stroke: gray, align(horizon, rotate(270deg)[Woche 0])),
    align(left, image("assets/anzupgo_before.png")),

    box(height: 100%, width: 100%, fill: luma(220), stroke: gray, align(horizon, rotate(270deg)[Woche 16])),
    align(left, image("assets/anzupgo_after.png")),
  ),
)

// ─── Psoriasis ────────────────────────────────────────────────────────────────

= Psoriasis

#slide(title: [Topische Therapie])[
  #let card_rows = (16pt, 1fr)
  #set text(14pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (1fr, 1fr),
    gutter: 12pt,
    card(title: [Salicylsäure], rows: card_rows)[
      - Wirkt abschuppend
      - Verbessert Wirksamkeit nachfolgender Topika

      *Präparate*
      - Squamasol Lösung (10% Salicylsäure)
      - Salicylvaseline (z.B. 5/10% Salicylsäure)
    ],
    card(title: [Vitamin-D Analoga], rows: card_rows)[
      - Beeinflusst epidermale Differenzierung
      - Nicht mehr als 30% der KOF

      *Präparate*
      - Curatoderm Lösung (Tacalcitol)
      - Daivonex Creme (Calcipotriol)
      - Silkis Salbe (Calcitriol)
    ],
    card(title: [Topische Kortikosteroide], rows: card_rows)[
      - Wirken gut an der Kopfhaut

      *Präparate*
      - Clarelux Schaum (Clobetasolpropionat)
      - Clobegalen Lösung / Shampoo (Clobetasolpropionat)
    ],

    card(title: [Calcineurininhibitoren], rows: card_rows)[
      - Immunsuppression ohne Steroidnebenwirkungen
      - Gut im Gesicht

      *Präparate*
      - Sumilor Lösung (Tacrolimus)
      - Elidel Creme (Pimecrolimus)
      - Protopic Salbe (Tacrolimus)
    ],
    card(title: [Kombinationspräparate], rows: card_rows)[
      *Präparate*
      - Daivobet Salbe (Calcipotriol/Betamethason)
      - Wynzora Creme (Calcipotriol/Betamethason)
      - Enstilar Schaum (Calcipotriol/Betamethason)
    ],
    card(title: [Dithranol], rows: card_rows)[
      - 1913 entdeckt
      - Hemmt Proliferation der Keratinozyten
      - Genauer Wirkmechanismus unbekannt
      - Stark reizend und färbend
      - Seit 2022 nicht als Fertigpräparat verfügbar
      - Oft nur stationär sinnvoll
    ],
  )
]

== Kopfhaut
#grid(
  columns: (3fr, 2fr),
  gutter: 12pt,
  image("assets/pso_haaransatz.JPG"),
  uncover("2-")[
    *Beispiel*
    - Squamasol (Salicylsäure) zum Abschuppen
    - Clarelux (Clobetasolpropionat) anfangs täglich, später im Wechsel mit
    - Sumilor (Tacrolimus)
  ],
)

== Gesicht
#grid(
  columns: (3fr, 2fr),
  gutter: 12pt,
  image("assets/pso_gesicht.JPG"),
  uncover("2-")[
    *Beispiel*
    - Elidel (Pimecrolimus)
    - Curatoderm (Tacalcitol)
  ],
)

== Ellenbogen
#grid(
  columns: (3fr, 2fr),
  gutter: 12pt,
  image("assets/ellenbogen.JPG"),
  uncover("2-")[
    *Beispiel*
    - Salicylvaseline (10% Salicylsäure) zum Abschuppen
    - Wynzora (Calcipotriol/Betamethason)
    - Enstilar (Calcipotriol/Betamethason)
  ],
)

== Nägel
#grid(
  columns: (3fr, 2fr),
  gutter: 12pt,
  image("assets/pso_naegel.JPG"),
  uncover("2-")[
    *Beispiel*
    #block(
      fill: rgb(247, 223, 223),
      inset: (x: 1em, y: 0.8em),
      radius: 4pt,
      width: 100%,
      [
        #set text(16pt)
        #table(
          columns: 2,
          fill: none,
          stroke: none,
          [Clobetasol propionas], [0,05%],
          [DMSO], [q.s.],
          [Sililevo Nagellack], [3,3 ml],
        )
        d.s. Nagellack bei Nagelpsoriasis, 1x täglich vor dem Schlafengehen auf die betroffenen Nägel auftragen
      ],
    )
  ],
)

#slide(title: [Zusammenfassung], section: none)[
  - *Vehikel:* nach Hautzustand und Lokalisation wählen
  - *Menge:* 1 Fingerspitze (0,5 g) reicht für 2% KOF
  - *Rezepturen:* wenn kein passendes Fertigarzneimittel existiert
  - *Kortikosteroide:* Klasse und therapeutischer Index, Therapieprinzipien
  - *Calcineurininhibitoren:* steroidfrei, gut für Gesicht, Hals, Beugen, Genital, brennen anfangs
  - *JAK-Inhibitoren:* teuer, zugelassen für Vitiligo (Ruxolitinib), Handekzem (Delgocitinib)
  - *Beispiel Psoriasis:* Therapie nach Lokalisation wählen und kombinieren
]

// Abschlussfolie
#end-slide()

#slide(title: [Evaluation], section: none)[
  #grid(
    columns: 2,
    card(title: [Veranstaltung], align(center, image("assets/qr_iklic.jpg"))),
    card(title: [Persönlich], align(center, image("assets/evaluation_vw.png"))),
  )
]
