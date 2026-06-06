# Deployment: iOS (Apple App Store)

## Prerequisites

- Mac with macOS (Xcode only runs on macOS — no Windows/Linux build possible)
- Xcode (latest version from the Mac App Store)
- [Apple Developer account](https://developer.apple.com) ($99 USD/year)
- Flutter SDK installed
- `flutter doctor` shows no iOS errors

---

## 1. App Identity

| Field | Value |
|---|---|
| App name (display) | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Bundle ID | `app.pimankagom` |
| Bundle ID in App Store | = Bundle ID, **cannot be changed after first release** |

---

## 2. Create App in App Store Connect

1. Open [App Store Connect](https://appstoreconnect.apple.com)
2. **My Apps → +** → New App
3. Fill in the fields:
   - **Platform**: iOS
   - **Name**: `Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ`
   - **Primary language**: English (or preferred language)
   - **Bundle ID**: `app.pimankagom` (must be registered in Apple Developer Portal first)
   - **SKU**: any internal code, e.g. `pimankagom-001`

---

## 3. Certificates and Provisioning Profiles

### Via Xcode (recommended for beginners)

1. Open Xcode → Settings → Accounts → Add Apple ID
2. Open project: `ios/Runner.xcworkspace`
3. Select target **Runner** → **Signing & Capabilities**
4. Enable **Automatically manage signing**
5. Select team → Xcode creates the certificate and provisioning profile automatically

### Manually (Apple Developer Portal)

1. [developer.apple.com](https://developer.apple.com) → Certificates, IDs & Profiles
2. **Identifiers → +** → App ID → Bundle ID: `app.pimankagom`
3. **Certificates → +** → Create Apple Distribution Certificate
4. **Profiles → +** → Create App Store Distribution Profile, link App ID and certificate

---

## 4. App Icon

All sizes must be present (no alpha channel!).

### flutter_launcher_icons (recommended)

In `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.0

flutter_launcher_icons:
  android: false
  ios: true
  image_path: "assets/icon/icon.png"  # 1024x1024 px, PNG, no alpha channel
```

```bash
dart run flutter_launcher_icons
```

### Manually

Replace icons in `ios/Runner/Assets.xcassets/AppIcon.appiconset/` (all sizes from `Contents.json`).

---

## 5. Set Version

In [pubspec.yaml](../pubspec.yaml):

```yaml
version: 1.0.0+1
#        ^^^^^  = CFBundleShortVersionString (e.g. 1.0.0)
#              ^ = CFBundleVersion (must be incremented on every upload)
```

---

## 6. Create Release Build

```bash
flutter build ipa --release
```

Output file:
```
build/ios/ipa/pimankagom.ipa
```

Alternative: archive via Xcode: **Product → Archive**

---

## 7. Upload to App Store Connect

### Option A: Xcode Organizer

1. Open **Window → Organizer**
2. Select archive → **Distribute App → App Store Connect → Upload**

### Option B: Transporter (Mac App Store app)

1. Open Transporter
2. Drag & drop the `.ipa` file
3. Click **Deliver**

### Option C: xcrun altool (Terminal)

```bash
xcrun altool --upload-app \
  -f build/ios/ipa/pimankagom.ipa \
  -t ios \
  -u YOUR_APPLE_ID_EMAIL \
  -p YOUR_APP_SPECIFIC_PASSWORD
```

---

## 8. Fill in Store Listing

In App Store Connect under **App Information** and **iOS App → Version**:

| Field | Content |
|---|---|
| Name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Subtitle | Pimankagom (max. 30 characters, for search) |
| Description | max. 4000 characters |
| Keywords | Pimankagom, Pimaenkagom, ... (max. 100 characters) |
| Support URL | own website or email link |
| Screenshots | min. 1 screenshot for iPhone 6.5" and 5.5" |
| App preview | optional, video max. 30 sec. |
| Privacy policy URL | required |

---

## 9. Privacy and Compliance

Apple requires information about:
- **Privacy policy** (URL required)
- **Privacy practices** (what data is collected?)
- **Export compliance**: If no cryptography is used → "No cryptographic algorithms"

---

## 10. Submit for Review

1. Select build in App Store Connect
2. Fill in all required fields
3. **Submit for Review**

> Apple Review typically takes 1–3 days. First submissions may take longer.

---

## Checklist

- [ ] Apple Developer account active ($99 USD/year paid)
- [ ] App created in App Store Connect
- [ ] Bundle ID `app.pimankagom` registered in Developer Portal
- [ ] Certificate and provisioning profile valid
- [ ] App icon without alpha channel, all sizes present
- [ ] Version set in `pubspec.yaml`
- [ ] `flutter build ipa --release` successful
- [ ] IPA uploaded (Xcode / Transporter)
- [ ] Store listing complete (screenshots, description, privacy URL)
- [ ] Submitted for review
