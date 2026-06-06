# Deployment: Windows (MSIX / Microsoft Store)

## Prerequisites

- Windows 10 or Windows 11
- Flutter SDK with Windows support: `flutter config --enable-windows-desktop`
- Visual Studio 2022 with workload **Desktop development with C++** installed
- `flutter doctor` shows no Windows errors
- For Microsoft Store: [Partner Center account](https://partner.microsoft.com) (one-time fee: $19 USD for individuals, $99 USD for companies)

---

## 1. App Identity

| Field | Value |
|---|---|
| App name (display) | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Publisher | from Partner Center (e.g. `CN=Your Name`) |
| Package name | assigned in Partner Center |
| Version | from `pubspec.yaml` |

---

## 2. Set App Name in Windows Configuration

In [windows/runner/main.cpp](../windows/runner/main.cpp) set the window title:

```cpp
window.Create(L"Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ", origin, size);
```

---

## 3. Set App Icon

The Windows app icon is located at `windows/runner/resources/app_icon.ico`.

An `.ico` file must contain multiple sizes: 16, 32, 48, 64, 128, 256 px.

### Create Icon

1. Export image as 256×256 px PNG
2. Convert to `.ico` with all sizes using a tool (e.g. [IcoFX](https://icofx.ro), GIMP, or an online converter)
3. Save as `windows/runner/resources/app_icon.ico`

---

## 4. Set Version

In [pubspec.yaml](../pubspec.yaml):

```yaml
version: 1.0.0+1
```

Windows reads the version automatically from `pubspec.yaml`.

---

## 5. Create Release Build

```bash
flutter build windows --release
```

Output:
```
build/windows/x64/runner/Release/
```

This folder contains the `.exe` and all required DLLs.

---

## 6. Create MSIX Package

MSIX is the installation format for the Microsoft Store (and also for direct installation).

### 6a. Add Package

In `pubspec.yaml`:

```yaml
dev_dependencies:
  msix: ^3.16.8

msix_config:
  display_name: Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
  publisher_display_name: Your Name / Organization
  identity_name: app.pimankagom
  msix_version: 1.0.0.0
  logo_path: assets/icon/icon.png   # 256x256 px PNG
  capabilities: internetClient
```

### 6b. Build MSIX

```bash
dart run msix:create
```

Output: `build/windows/x64/runner/Release/pimankagom.msix`

---

## 7a. Direct Distribution (without Store)

The `.msix` package can be distributed directly. For installation, the target device must have **Developer Mode** enabled, or the package must be signed with a trusted certificate.

### Self-signed Certificate (for testing)

```powershell
# PowerShell as Administrator
New-SelfSignedCertificate `
  -Type Custom `
  -Subject "CN=Pimankagom" `
  -KeyUsage DigitalSignature `
  -FriendlyName "Pimankagom" `
  -CertStoreLocation "Cert:\LocalMachine\My" `
  -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")
```

---

## 7b. Microsoft Store Release

### Step 1: Create App in Partner Center

1. [partner.microsoft.com](https://partner.microsoft.com) → Dashboard → Create new app
2. Reserve app name: `Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ`
3. Note the **app identity** (Publisher ID, Package Name)

### Step 2: msix_config with Store Data

```yaml
msix_config:
  display_name: Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
  publisher_display_name: Your Name
  identity_name: YourName.pimankagom   # from Partner Center
  publisher: CN=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX  # from Partner Center
  msix_version: 1.0.0.0
  store: true
```

### Step 3: Create Store Build

```bash
flutter build windows --release
dart run msix:create
```

### Step 4: Upload

1. Partner Center → App submission → Packages → upload `.msix`
2. Fill in store listing:
   - Description (min. 200 characters)
   - Screenshots (min. 1, recommended: 3–5)
   - Select category
3. Submit → Submit for certification

> Microsoft Review typically takes 1–3 business days.

---

## 8. Store Listing

| Field | Content |
|---|---|
| Name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ |
| Description | min. 200 characters, search terms: Pimankagom, Pimaenkagom |
| Short description | max. 270 characters |
| Screenshots | min. 1, recommended: 1280×720 or 1920×1080 px |
| App icon | 300×300 px, PNG |
| Privacy policy URL | required |

---

## Checklist

- [ ] Visual Studio 2022 with C++ workload installed
- [ ] `flutter config --enable-windows-desktop` executed
- [ ] Window title set in `main.cpp`
- [ ] App icon set as `.ico`
- [ ] Version set in `pubspec.yaml`
- [ ] `flutter build windows --release` successful
- [ ] `msix` package configured in `pubspec.yaml`
- [ ] MSIX package built
- [ ] Store listing fully filled in (for Store release)
- [ ] Upload to Partner Center completed (for Store release)
