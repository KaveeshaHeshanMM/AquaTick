# AquaTick – Pond Dashboard & Water Quality Screens

My part of **AquaTick**, a smart IoT fish farming system we built as our Software Development Group Project (SDGP) at IIT Sri Lanka.

AquaTick lets fish farmers check their ponds from a phone. ESP32 sensors measure pH, temperature and water level and send the readings to Firebase. The Flutter app shows those readings live, raises alerts and can trigger an automatic feeder.

This repo only contains the screens I worked on. The full project (firmware, AI feeding model and the rest of the app) is in our team's private repository.

## What I built

### Pond Dashboard (`lib/screens/pond_dashboard_page.dart`)
- Header section for the selected pond
- Realtime Firebase listener that orders readings by timestamp and pulls the latest one
- Water quality parameter cards (pH, temperature, water level)
- Colour logic for the water level status
- Reusable widget for showing a single parameter
- Buttons to open the other features (water quality, feeding, alerts)
- Bottom navigation bar and sign-out from the logout button

### Water Quality Details (`lib/screens/water_quality_details.dart`)
- Reads the last 5 sensor readings from Firebase Realtime Database, ordered by timestamp
- Converts the Firebase snapshot into a map and extracts temperature and pH values
- Sorts the readings chronologically and updates the graph when new data arrives
- Line charts for temperature and pH using `fl_chart` (custom axis ranges, titles and R1–R5 labels)
- Reusable graph widget and a gradient header section

## Tech stack

- Flutter / Dart
- Firebase Realtime Database, Firebase Auth
- fl_chart

## Database structure used

```
sensorReadings/
  pond1/
    <readingId>/
      temperature: 27.4
      ph: 7.1
      waterLevel: "OK"
      timestamp: 1708851234
```

## Running it

These screens are part of a bigger app, so they need the rest of the AquaTick project (start screen, dashboard, Firebase setup) to run on their own. To try them in your own Flutter project:

1. Copy the `lib/` folder into your project
2. Add the dependencies from `pubspec.yaml`
3. Connect Firebase with `flutterfire configure`
4. Push some test data to `sensorReadings/pond1`

## Team

AquaTick was built by a team of six at IIT, led by Sineth Wijekoon. Some commits in this history are from teammates because we worked on the same files – I kept them so the history stays accurate.

**Kaveesha Heshan Marasinghe** – [GitHub](https://github.com/KaveeshaHeshanMM)
