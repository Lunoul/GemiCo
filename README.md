# GemiCo

Android client for Google Gemini. The idea is to keep **one** model (the same Gemini model you pick in settings) for everything, but switch between a normal chat mode and a mode where **your own system prompt** is sent—so you can supply an “anti-censorship” or unrestricted-style instruction without relying on a separate censored product: you edit that text under **Settings → +18 prompt**, enable **+18** in the chat UI when you want it, and switch back to the default mode for ordinary use.

## API key

1. Create a key in [Google AI Studio](https://aistudio.google.com/apikey).
2. Open **Settings → Gemini API key** in the app and paste it. The key is stored only in local preferences on the device.

If an API key was ever committed to a repository or embedded in a build, treat it as compromised and **revoke or rotate** it in Google AI Studio.


## Getting started (development)

```bash
flutter pub get
flutter gen-l10n   # if lib/l10n/app_localizations*.dart are missing (generated from *.arb)
flutter run
```

The default `flutter build apk --release` produces one **fat** APK (~50MB) with all CPU architectures.

For a **much smaller** install file (typical phone: use `app-arm64-v8a-release.apk`):

```bash
flutter build apk --release --split-per-abi
```

Outputs are under `build/app/outputs/flutter-apk/`.
