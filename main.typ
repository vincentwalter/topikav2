#import "@preview/touying:0.7.3": *
#import "ukt-theme.typ": *

#set text(lang: "de")
#set list(marker: "—")
#set table(
  stroke: gray,
  fill: (_, y) => if y == 0 { luma(220) },
  inset: 8pt,
)
#show table.cell: cell => if cell.y == 0 { strong(cell) } else { cell }

#show: ukt-theme.with(
  config-info(
    title: [Titel der Präsentation],
    author: [Vorname Nachname],
    date: [TT.MM.JJJJ],
  ),
  // Optionaler Text neben der Foliennummer, z. B. [Klinik / Abteilung].
  title-or-chapter: none,
)

// Titelfolie
#title-slide(
  background: "assets/title-bg.jpeg",
  title_size: 44pt,
  title_strip_width: 65%,
)

// Kapiteltrenner
#section-slide(
  title: [Kapitelüberschrift],
  subtitle: [Optionale Unterzeile],
)

// Standard-Inhaltsfolie
#slide(section: [Kapitelüberschrift], title: [Inhaltsfolie])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      *Linke Spalte*
      - Kernaussage klar formulieren
      - Inhalte auf das Wesentliche reduzieren
      - Hervorhebungen sparsam einsetzen
    ],
    [
      *Rechte Spalte*
      - Abbildungen mit Quellen versehen
      - Pro Folie eine Hauptbotschaft
      - Genügend Weißraum lassen
    ],
  )
  #cite[Quelle: Autor et al., Zeitschrift Jahr]
]

// Karten und Tabellen
#slide(title: [Weitere Bausteine])[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    card(
      title: [Merksatz],
      [Diese Karte eignet sich für eine kurze, hervorgehobene Aussage.],
    ),
    table(
      columns: (1fr, 1fr),
      [Merkmal], [Wert],
      [Beispiel A], [10],
      [Beispiel B], [20],
    ),
  )
]

// Abschlussfolie
#end-slide()
