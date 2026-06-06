# Deployment: macOS (Mac App Store)

## Prerequisites

- Mac with macOS (build only possible on macOS)
- Xcode (latest version)
- [Apple Developer account](https://developer.apple.com) ($99 USD/year — same as for iOS)
- Flutter SDK with macOS support: `flutter config --enable-macos-desktop`
- `flutter doctor` shows no macOS errors
- CocoaPods installed: `sudo gem install cocoapods`

---

## 1. App Identity

| Field | Value | File |
|---|---|---|
| Display name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ | [macos/Runner/Info.plist](../macos/Runner/Info.plist) |
| Bundle name (technical) | pimankagom | [macos/Runner/Configs/AppInfo.xcconfig](../macos/Runner/Configs/AppInfo.xcconfig) |
| Bundle ID | `app.pimankagom` | AppInfo.xcconfig |
| Copyright | Copyright © 2026 app.pimankagom | AppInfo.xcconfig |

---

## 2. Create App in App Store Connect

1. Open [App Store Connect](https://appstoreconnect.apple.com)
2. **My Apps → +** → New App
3. Fill in the fields:
   - **Platform**: macOS
   - **Name**: `Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ`
   - **Bundle ID**: `app.pimankagom`
   - **SKU**: e.g. `pimankagom-mac-001`

---

## 3. Certificates and Provisioning Profiles

### Via Xcode (recommended)

1. Open `macos/Runner.xcworkspace` in Xcode
2. Target **Runner** → **Signing & Capabilities**
3. Enable **Automatically manage signing**
4. Select team → Xcode creates everything automatically

Two certificates are required for App Store distribution:
- **Apple Distribution** (for the app code)
- **3rd Party Mac Developer Installer** (for the `.pkg` package)

### Entitlements

All required permissions must be declared in `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`. **App Sandbox** is mandatory for the Mac App Store:

```xml
<key>com.apple.security.app-sandbox</key>
<true/>
```

If network access is needed:
```xml
<key>com.apple.security.network.client</key>
<true/>
```

---

## 4. Set App Icon

Replace all sizes in `macos/Runner/Assets.xcassets/AppIcon.appiconset/`.

### flutter_launcher_icons

In `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: false
  ios: false
  macos:
    generate: true
    image_path: "assets/icon/icon.png"  # 1024x1024 px PNG
```

```bash
dart run flutter_launcher_icons
```

---

## 5. Set Version

In [pubspec.yaml](../pubspec.yaml):

```yaml
version: 1.0.0+1
```

---

## 6. Create Release Build

```bash
flutter build macos --release
```

Output:
```
build/macos/Build/Products/Release/pimankagom.app
```

---

## 7. Archive and Upload App

### Via Xcode

1. Open `macos/Runner.xcworkspace` in Xcode
2. **Product → Archive**
3. In Organizer: **Distribute App → App Store Connect → Upload**

### Via xcrun (Terminal)

```bash
# Create archive
xcodebuild archive \
  -workspace macos/Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/pimankagom.xcarchive

# Export
xcodebuild -exportArchive \
  -archivePath build/pimankagom.xcarchive \
  -exportPath build/export \
  -exportOptionsPlist ExportOptions.plist
```

---

## 8. Notarization (outside Mac App Store)

For direct distribution (outside the Mac App Store) the app must be notarized:

```bash
# Package app bundle as ZIP
ditto -c -k --keepParent \
  "build/macos/Build/Products/Release/pimankagom.app" \
  "build/pimankagom.zip"

# Submit for notarization
xcrun notarytool submit build/pimankagom.zip \
  --apple-id YOUR_APPLE_ID \
  --team-id YOUR_TEAM_ID \
  --password YOUR_APP_SPECIFIC_PASSWORD \
  --wait

# Staple (embed into app bundle)
xcrun stapler staple "build/macos/Build/Products/Release/pimankagom.app"
```

---

## 9. Fill in Store Listing

In App Store Connect:

| Field | Content |
|---|---|
| Name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Subtitle | Pimankagom (for search, max. 30 characters) |
| Description | max. 4000 characters |
| Keywords | Pimankagom, Pimaenkagom, ... |
| Screenshots | min. 1, recommended: 1280×800 or 2560×1600 px |
| Privacy policy URL | required |
| Support URL | required |

---

## 10. Submit for Review

1. Select build in App Store Connect
2. Fill in all required fields
3. **Submit for Review**

> Apple Review typically takes 1–3 days.

---

## Checklist

- [ ] Apple Developer account active
- [ ] `flutter config --enable-macos-desktop` executed
- [ ] App created in App Store Connect (macOS)
- [ ] Bundle ID `app.pimankagom` registered
- [ ] Certificates set up in Xcode
- [ ] App Sandbox enabled in entitlements
- [ ] App icon set (all sizes)
- [ ] Version set in `pubspec.yaml`
- [ ] `flutter build macos --release` successful
- [ ] Archive created in Xcode and uploaded
- [ ] Store listing fully filled in
- [ ] Submitted for review
