# CLAUDE.md — Project Context

## Language Rules

- **All code, comments, variable names, and commit messages in English**
- Conversation with the user is in **German**
- Documentation files under `docs/` are in English (user-facing)

## Project Identity

| Field                   | Value                   |
| ----------------------- | ----------------------- |
| App name (display)      | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ              |
| Technical name          | `pimankagom`            |
| Bundle / Application ID | `app.pimankagom`        |
| Search aliases          | Pimankagom, Pimaenkagom |
| pubspec name            | `pimankagom`            |

## Target Platforms

Android, iOS, Web, Windows, macOS, Linux — in that priority order.

## Tech Stack

- Flutter + Dart
- State management: `flutter_riverpod`
- Secure storage: `flutter_secure_storage`
- No backend, no Firebase SDK — pure client app
- Web hosting: Firebase Hosting (`firebase deploy` after `flutter build web`)

## Key Files

| File                                                         | Purpose                                  |
| ------------------------------------------------------------ | ---------------------------------------- |
| `pubspec.yaml`                                               | Version, name, dependencies              |
| `android/app/build.gradle.kts`                               | Android applicationId, namespace         |
| `android/app/src/main/AndroidManifest.xml`                   | Android label (display name)             |
| `android/app/src/main/kotlin/app/pimankagom/MainActivity.kt` | Android entry point                      |
| `ios/Runner/Info.plist`                                      | iOS CFBundleDisplayName, CFBundleName    |
| `ios/Runner.xcodeproj/project.pbxproj`                       | iOS bundle ID                            |
| `macos/Runner/Configs/AppInfo.xcconfig`                      | macOS PRODUCT_NAME, bundle ID            |
| `macos/Runner/Info.plist`                                    | macOS CFBundleDisplayName                |
| `web/manifest.json`                                          | Web app name, short_name                 |
| `web/index.html`                                             | Browser title, meta tags                 |
| `windows/runner/main.cpp`                                    | Windows window title                     |
| `windows/runner/Runner.rc`                                   | Windows EXE metadata                     |
| `windows/CMakeLists.txt`                                     | Windows BINARY_NAME                      |
| `linux/CMakeLists.txt`                                       | Linux BINARY_NAME, APPLICATION_ID        |
| `linux/runner/my_application.cc`                             | Linux window title                       |
| `scripts/rename_app.dart`                                    | Renames app across all platforms at once |

## Rename Script

To rename the app across all platforms:

```bash
dart run scripts/rename_app.dart
# or with arguments:
dart run scripts/rename_app.dart --name newname --display-name "New Name" --bundle-id com.example.new --description "..."
# dry run (no files changed):
dart run scripts/rename_app.dart --dry-run
```

## Deployment Documentation

Step-by-step guides for each platform live in `docs/`:

- `docs/deployment_android.md`
- `docs/deployment_ios.md`
- `docs/deployment_web.md`
- `docs/deployment_windows.md`
- `docs/deployment_macos.md`
- `docs/deployment_linux.md`

## Architecture

```
lib/
  models/        # Pure data classes (nodes, contents, config)
    core/        # Base classes: Node, Content
    nodes/       # Book, Library, Collection, Chapter, Section, Clause, Paragraph, Part
    contents/    # MultilingualText, Text
    configurations/ # Setting, SettingList
  data/          # Static data instances (books, libraries, etc.)
  repositories/  # SettingsRepository (reads/writes via LocalStorageService)
  services/      # LocalStorageService, DefaultSettingsService, AppearanceService
  ui/
    nodes/       # Widgets per node type + navigation helpers
    contents/    # MultilingualText widgets + language state
    configurations/ # Settings screen (Riverpod: state/notifier/provider/widgets)
  constants/     # Languages
  app.dart       # Root MaterialApp
  main.dart      # Entry point
```

### State Management Pattern

Riverpod is used for all shared state. Each feature has:

- `*_state.dart` — the state class
- `*_notifier.dart` — the StateNotifier
- `*_provider.dart` — the Provider definition
- `widgets/` — UI consuming the provider

## Coding Conventions

- No comments unless the WHY is non-obvious
- No docstrings
- Prefer `const` constructors
- Widget files contain one widget per file
- Repository pattern for persistence — never access storage directly from UI
