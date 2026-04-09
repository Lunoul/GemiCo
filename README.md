# GemiCo
![unnamed](https://github.com/user-attachments/assets/d002beab-cf66-467f-9750-134175ad4727)

Android client for Google Gemini. The idea is to keep **one** model (the same Gemini model you pick in settings) for everything, but switch between a normal chat mode and a mode where **your own system prompt** is sent—so you can supply an “anti-censorship” or unrestricted-style instruction without relying on a separate censored product: you edit that text under **Settings → +18 prompt**, enable **+18** in the chat UI when you want it, and switch back to the default mode for ordinary use.

## API key

1. Create a key in [Google AI Studio](https://aistudio.google.com/apikey).
2. Open **Settings → Gemini API key** in the app and paste it. The key is stored only in local preferences on the device.

If an API key was ever committed to a repository or embedded in a build, treat it as compromised and **revoke or rotate** it in Google AI Studio.

## Build (Android)

```bash
flutter pub get
flutter gen-l10n
flutter build apk --release
```
or
```bash
flutter build apk --release --split-per-abi
```

APKs are written to `build/app/outputs/flutter-apk/`. On a typical phone install **`app-arm64-v8a-release.apk`** (about ~20 MB).

If `lib/l10n/app_localizations*.dart` is missing after a clone, run `flutter gen-l10n` once before building.
