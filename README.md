# conferenceTransform

`conferenceTransform` verarbeitet Konferenzdaten im XML-Format und erzeugt daraus XML-Dateien für den Import in Adobe InDesign.

## Funktionsumfang

- Führt alle XML-Dateien (`*.xml`) aus einem Eingabeordner zu einem gemeinsamen Datenbestand zusammen (Kombi-Konferenzen).
- Bereinigt HTML-Tags und bestimmte HTML-Entities in Beschreibungen.
- Filtert Sessions anhand ihres Startzeitpunkts auf einen angegebenen Zeitraum und sortiert die Einträge.
- Erzeugt bis zu 20 XML-Ausgabedateien: Namenslisten, Keynotes, Sessions und Workshops in unterschiedlichen Varianten (mit/ohne Datum und Raum), Social-Media-Varianten sowie Tabellen für Raum- und Zeitpläne.

## Voraussetzungen

- Java herunterladen + installieren: [Eclipse Temurin 8 herunterladen](https://adoptium.net/temurin/releases/?version=8)
  - Auf der Seite die folgenden Optionen auswählen:
    - **Operating System:** `macOS`
    - **Architecture:** `aarch64` für einen Mac mit Apple-Chip oder `x64` für einen Intel-Mac. 
    - **Package Type:** `JDK`
    - Download startet.
- Die Eingabedateien müssen gültige Konferenz-XML-Dateien sein, deren Daten unter anderem die von der Transformation erwartete Struktur `conferenceData` enthalten.
- Das Skript wird aus dem Projektverzeichnis ausgeführt. Die Verzeichnisse `temp/` und `indesign-out/` müssen vorhanden und beschreibbar sein; sie sind im Projekt enthalten.

## Installation

1. Neueste Version des Tools herunterladen (ZIP): https://github.com/mschuetze/conferenceTransform/releases

   Auf der Release-Seite unter **Assets** auf **Source code (zip)** klicken:

   ![Download der ZIP-Datei auf der GitHub-Release-Seite](./_Bilder/conferencetransform-downloadZIP.png)

2. ZIP entpacken und in beliebeigen Ordner (z.B. Schreibtisch) kopieren/verschieben.
3. fertig.

## Benutzung

1. Konferenz-XML herunterladen und ablegen siehe Manual. 
2. Ordner "conferenceTransform" im Finder öffnen.
3. XML-Datei in Unterordner `input` kopieren.
4. Datei `start_conferenceTransform` öffnen und per PLAY-Button (oben rechts) ausführen.