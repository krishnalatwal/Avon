# Avon Registration App

A Flutter registration flow built as a developer-transition learning project. The UI is implemented milestone by milestone from four prepared Figma designs, each one adding more registration features on top of the last.

## Project status

Currently implemented: **Version 4 — Complete registration** (all four UI milestones done)

| Version | Scope | Status |
|---|---|---|
| 1 — Basic | Email, password, create-account action, terms/privacy links, login link | Done |
| 2 — Standard | Adds full name, password visibility toggle, password guidance, terms acceptance | Done |
| 3 — Enhanced | Adds Apple/Google sign-in entry points, optional phone number (with a real country picker), password-strength feedback | Done |
| 4 — Complete | Adds email/phone method selector (visual only — no Phone-primary form is designed yet), recovery phone, confirm password, password requirements checklist, marketing consent, supporting guidance | Done |

No backend is connected yet. Authentication, persistence, email verification, and social sign-in are not implemented — the Apple/Google buttons and the email verification/recovery-phone copy are UI only until Firebase is wired up. Backend work (starting with Firebase Authentication) is the next milestone.

## Project structure

```
lib/
  main.dart                          # App entry point
  screens/
    registration/
      registration_screen.dart       # Registration form (Version 4)
    home/
      home_screen.dart                # Placeholder landing screen after submit
  widgets/
    aven_text_field.dart              # Shared styled text input
    aven_primary_button.dart          # Shared primary action button
    aven_checkbox_row.dart            # Shared checkbox + rich-text label row
    aven_social_button.dart           # Shared Apple/Google entry-point button
  theme/
    app_colors.dart                   # Shared color tokens
    app_text_styles.dart              # Shared text styles
```

## Getting started

Requirements: a stable Flutter SDK install (`flutter --version` to check) with iOS and/or Android tooling set up.

```bash
flutter pub get      # install dependencies
flutter analyze       # static analysis
flutter test          # run tests
flutter run            # run on a connected device or simulator
```

## Git workflow

- `main` is the stable branch.
- Each design milestone lives on its own branch: `version-1-basic`, `version-2-standard`, `version-3-enhanced`, `version-4-complete`.
- Branches are merged via Pull Request; history is not rewritten or force-pushed.

## Notes

- Dependencies are kept minimal — `google_fonts` (Figma typography) and `country_picker` (international phone country/dial-code selection) are the only non-default packages.
- See `CLAUDE.md` for the full set of working conventions (design fidelity, milestone pacing, Firebase rules, and Git permissions) followed while building this project.
