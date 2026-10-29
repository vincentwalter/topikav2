# UKT-Präsentationsvorlage

Eine Typst-Vorlage im Design des Universitätsklinikums Tübingen, abgeleitet aus
der Präsentation im Projekt `Zunge`.

## Verwendung

1. Titel, Autor und Datum in `main.typ` anpassen.
2. Beispielinhalte durch die eigenen Folien ersetzen.
3. Zusätzliche Bilder unter `assets/` ablegen.
4. Die Präsentation kompilieren:

   ```sh
   ./compile.sh
   ```

Alternativ direkt mit `typst compile main.typ presentation.pdf` kompilieren.
Beim ersten Lauf lädt Typst das Paket `@preview/touying:0.7.3` herunter, falls es
noch nicht lokal vorhanden ist.

## Folientypen

- `#title-slide(...)`: Titelfolie mit Hintergrundbild
- `#section-slide(...)`: Kapiteltrenner
- `#slide(...)`: Inhaltsfolie
- `#end-slide()`: Abschlussfolie

Die Hilfsfunktionen `#card(...)` und `#cite[...]` sind ebenfalls in
`ukt-theme.typ` definiert. Farben, Logos, Seitenformat und Typografie werden
zentral über `#show: ukt-theme.with(...)` konfiguriert.
