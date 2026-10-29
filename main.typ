#import "ukt-talk.typ": *

#set text(lang: "de")
#set list(marker: "—")
#set table(
  stroke: gray,
  fill: (_, y) => if y == 0 { luma(220) },
  inset: 8pt,
)
#show table.cell: cell => if cell.y == 0 { strong(cell) } else { cell }

#show: ukt-talk.with(
  title: [Titel der Präsentation],
  author: [Vorname Nachname],
  date: [TT.MM.JJJJ],
  // Optionaler Text neben der Foliennummer, z. B. [Klinik / Abteilung].
  title-or-chapter: none,
  // Handout: Folienbilder neben dem Text (true) oder nur die Handout-Texte (false).
  handout-slides: true,
  // Handout mit Folienbildern: auch Folien ohne Handout-Text aufnehmen.
  handout-all-slides: false,
)

// Titelfolie
#title-slide(
  background: "assets/title-bg.jpeg",
  title_size: 44pt,
  title_strip_width: 65%,
)
#notes[Begrüßung, kurz vorstellen. Ziel des Vortrags in einem Satz.]

// Kapiteltrenner: Überschrift erster Ebene
= Kapitelüberschrift

// Inhaltsfolie: Überschrift zweiter Ebene. Die Kapitelüberschrift erscheint
// automatisch als Unterzeile im Folienkopf.
== Inhaltsfolie

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
    #pause
    *Rechte Spalte*
    - Abbildungen mit Quellen versehen
    - Pro Folie eine Hauptbotschaft
    - Genügend Weißraum lassen
  ],
)
#cite[Quelle: Autor et al., Zeitschrift Jahr]

#notes[
  Erst die linke Spalte erklären, dann weiterklicken.
  - Beispiel aus der Praxis nennen
  - Auf die Quelle hinweisen
]

#handout[
  Ausführlicher Text für das Handout: Hintergrund, Herleitung und Details, die
  auf der Folie keinen Platz haben. *Formatierung* funktioniert wie überall in
  Typst.

  Weiterführende Literatur: Autor et al., Zeitschrift Jahr.
]

// Folie mit explizitem Aufruf, z. B. für eigene Titel oder Unterzeilen
#slide(title: [Weitere Bausteine], section: none)[
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
#notes[Tabelle nur kurz zeigen, nicht vorlesen.]
#handout[Erläuterung der Tabellenwerte für Leserinnen und Leser.]

// Abschlussfolie
#end-slide()
#notes[Fragen einsammeln.]
