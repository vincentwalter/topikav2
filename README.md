# UKT-Präsentationsvorlage

Eine Typst-Vorlage im Design des Universitätsklinikums Tübingen, abgeleitet aus
der Präsentation im Projekt `Zunge`. Aus einer einzigen Quelldatei (`main.typ`)
entstehen Folien, Sprechernotizen, ein Handout und ein Sprechzettel.

## Verwendung

1. Titel, Autor und Datum in `main.typ` anpassen.
2. Beispielinhalte durch die eigenen Folien ersetzen, Notizen mit `#notes[...]`
   und Handout-Texte mit `#handout[...]` direkt zur jeweiligen Folie schreiben.
3. Zusätzliche Bilder unter `assets/` ablegen.
4. Alles kompilieren:

   ```sh
   ./compile.sh
   ```

Benötigt Typst 0.15 oder neuer. Beim ersten Lauf lädt Typst das Paket
`@preview/touying:0.8.0` herunter, falls es noch nicht lokal vorhanden ist.

## Ergebnisse in `build/`

| Datei               | Inhalt                                                    |
| ------------------- | --------------------------------------------------------- |
| `presentation.pdf`  | Folien zum Vortragen, mit Animationsschritten (`#pause`)  |
| `presentation.pdfpc`| Sprechernotizen für [pdfpc] oder [Pympress]               |
| `handout.pdf`       | A4: Folienbild neben dem Handout-Text                     |
| `handout-text.pdf`  | A4: nur die Handout-Texte, ohne Folienbilder              |
| `script.pdf`        | A4: Sprechzettel, jede Folie neben ihren Notizen          |
| `thumbs.pdf/.json`  | Zwischenstufe: eine Seite pro Folie und Seitenzuordnung   |

Während der Arbeit an den Folien reicht `typst watch main.typ`. Handout und
Sprechzettel brauchen den vollständigen Lauf von `compile.sh`. Ist
`build/thumbs.json` veraltet, bricht die Kompilierung mit einem Hinweis ab.

[pdfpc]: https://pdfpc.github.io
[Pympress]: https://github.com/Cimbali/pympress

## Folien schreiben

```typst
= Kapitel                    // Kapiteltrenner

== Folientitel               // Inhaltsfolie, Kapitel erscheint als Unterzeile

- Punkt eins
#pause
- Punkt zwei

#notes[Was ich dazu sage.]
#handout[Ausführlicher Text für das Handout.]
```

Folientypen:

- `#title-slide(...)`: Titelfolie mit Hintergrundbild
- `= Überschrift` oder `#section-slide(...)`: Kapiteltrenner
- `== Überschrift` oder `#slide(...)[...]`: Inhaltsfolie. Die Unterzeile im
  Folienkopf folgt automatisch dem aktuellen Kapitel; mit `section: none` wird
  sie unterdrückt, mit `section: [...]` überschrieben.
- `#end-slide()`: Abschlussfolie

`compile.sh` erzeugt beide Handout-Varianten. Die Textvariante enthält nur die
`#handout`-Texte in Reihenfolge; Überschriften innerhalb von `#handout[...]`
gliedern sie. Sie braucht `build/thumbs.*` nicht:

```sh
typst compile --input mode=handout --input handout-slides=false main.typ
```

Ohne `--input handout-slides=...` gilt die Einstellung `handout-slides` in
`ukt-talk.with(...)`.

`#notes` und `#handout` stehen entweder in der Folie oder direkt nach ihr.
Nicht innerhalb von `#only`, `#uncover` oder `#alternatives` verwenden.

Die Hilfsfunktionen `#card(...)` und `#cite[...]` sind in `ukt-theme.typ`
definiert. Farben, Logos, Seitenformat und Typografie werden dort zentral
konfiguriert, Handout und Sprechzettel in `ukt-talk.typ`.

## Funktionsweise

`ukt-talk.typ` wertet `--input mode=...` aus:

- `slides` (Standard): Folien; `#notes` wird zur Touying-Sprechernotiz.
- `thumbs`: eine Seite pro Folie; `#notes`/`#handout` hinterlassen Marker, aus
  denen `compile.sh` die Seitenzuordnung nach `build/thumbs.json` schreibt.
- `handout` / `script`: A4-Dokument, das die Seiten aus `build/thumbs.pdf` als
  Bilder einbettet und die Texte danebensetzt.
