# Deployment: Android (Google Play Store)

## Prerequisites

- Flutter SDK installed (`flutter doctor` shows no errors)
- Android Studio or JDK 17+ installed
- [Google Play Developer account](https://play.google.com/console) created (one-time fee: $25 USD)
- Account must be verified (ID required, may take a few days)

---

## 1. App Identity

| Field | Value |
|---|---|
| App name (display) | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Application ID | `app.pimankagom` |
| Package name in Play Store | = Application ID, **cannot be changed after first release** |

---

## 2. Create Keystore

The keystore is the signing certificate. Create it once and **keep it safe** — without it, no further updates are possible.

```bash
keytool -genkey -v \
  -keystore pimankagom-release.jks \
  -alias pimankagom \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

When prompted:
- **Password**: choose a strong password and write it down
- **Name, Org, City, Country**: can be filled with any values
- **Alias**: `pimankagom`

> **Important:** Never commit the `.jks` file to the Git repository.

---

## 3. Configure Signing in Android

### 3a. Create key.properties

Create the file `android/key.properties` (outside the repository or in `.gitignore`):

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=pimankagom
storeFile=../pimankagom-release.jks
```

### 3b. Update build.gradle.kts

Add the following to [android/app/build.gradle.kts](../android/app/build.gradle.kts):

```kotlin
import java.util.Properties
import java.io.FileInputStream

val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()
keyProperties.load(FileInputStream(keyPropertiesFile))

android {
    // ... existing config ...

    signingConfigs {
        create("release") {
            keyAlias = keyProperties["keyAlias"] as String
            keyPassword = keyProperties["keyPassword"] as String
            storeFile = file(keyProperties["storeFile"] as String)
            storePassword = keyProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

---

## 4. App Icon

The default Flutter icon must be replaced.

### Option A: flutter_launcher_icons (recommended)

1. Add the package to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.0

flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon/icon.png"  # 1024x1024 px, PNG
```

2. Generate icons:

```bash
dart run flutter_launcher_icons
```

### Option B: Manually

Replace icons in `android/app/src/main/res/mipmap-*/ic_launcher.png` at the correct resolutions: mdpi=48px, hdpi=72px, xhdpi=96px, xxhdpi=144px, xxxhdpi=192px.

---

## 5. Set Version

In [pubspec.yaml](../pubspec.yaml):

```yaml
version: 1.0.0+1
#        ^^^^^  = versionName  (shown in store)
#              ^ = versionCode (must be incremented on every upload)
```

---

## 6. Create Release Build

```bash
flutter build appbundle --release
```

Output file:
```
build/app/outputs/bundle/release/app-release.aab
```

> Alternative APK: `flutter build apk --release` (for direct distribution, not for Play Store)

---

## 7. Create App in Play Store

1. Open [Google Play Console](https://play.google.com/console)
2. **Create app** → select language, enter app name: `Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ`
3. App type: App / Game
4. Select Free / Paid

---

## 8. Fill in Store Listing

Under **Store presence → Main store listing**:

| Field | Content |
|---|---|
| App name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Short description | max. 80 characters |
| Full description | max. 4000 characters, include search terms: Pimankagom, Pimaenkagom |
| Screenshots | min. 2 screenshots (phone), optional tablet |
| Feature graphic | 1024 × 500 px |
| App icon | 512 × 512 px, PNG, max. 1 MB |

---

## 9. Upload AAB and Publish

1. **Production → Manage releases → Create release**
2. Upload the `.aab` file
3. Enter release notes
4. **Review** → **Start rollout**

> First release is reviewed by Google (typically 1–7 days).

---

## 10. Update .gitignore

Make sure the following entries exist in `.gitignore`:

```
android/key.properties
*.jks
*.keystore
```

---

## Checklist

- [ ] Google Play Developer account active
- [ ] Keystore created and stored safely
- [ ] `key.properties` created (not in Git)
- [ ] `build.gradle.kts` updated with signing config
- [ ] App icon replaced
- [ ] Version set in `pubspec.yaml`
- [ ] `flutter build appbundle --release` successful
- [ ] Store listing fully filled in
- [ ] AAB uploaded, release started
