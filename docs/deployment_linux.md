# Deployment: Linux

## Prerequisites

- Linux (Ubuntu 20.04+ or similar) — build only possible on Linux
- Flutter SDK with Linux support: `flutter config --enable-linux-desktop`
- Build dependencies:

```bash
sudo apt-get install \
  clang cmake ninja-build \
  libgtk-3-dev pkg-config \
  liblzma-dev libstdc++-12-dev
```

- `flutter doctor` shows no Linux errors

---

## 1. App Identity

| Field | Value | File |
|---|---|---|
| App name (window) | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ | [linux/runner/my_application.cc](../linux/runner/my_application.cc) |
| Executable name | pimankagom | [linux/CMakeLists.txt](../linux/CMakeLists.txt) |
| Desktop ID | app.pimankagom | `.desktop` file |

---

## 2. Set App Name in Linux Configuration

In [linux/runner/my_application.cc](../linux/runner/my_application.cc):

```cpp
gtk_window_set_title(window, "Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ");
```

In [linux/CMakeLists.txt](../linux/CMakeLists.txt):

```cmake
set(BINARY_NAME "pimankagom")
set(APPLICATION_ID "app.pimankagom")
```

---

## 3. Set App Icon

The icon is needed as PNG in various sizes.

1. Place icons in `linux/` (e.g. `linux/pimankagom.png`, 256×256 px)
2. Reference in the `.desktop` file

---

## 4. Set Version

In [pubspec.yaml](../pubspec.yaml):

```yaml
version: 1.0.0+1
```

---

## 5. Create Release Build

```bash
flutter build linux --release
```

Output:
```
build/linux/x64/release/bundle/
```

This folder contains:
- `pimankagom` (executable)
- `lib/` (shared libraries)
- `data/` (Flutter assets)

---

## 6. Distribution Options

### Option A: Snap Store (Ubuntu/Snapcraft — recommended)

The Snap Store is the easiest way to distribute Linux apps broadly (works on Ubuntu, Fedora, Arch, etc.).

**Create account:** [snapcraft.io](https://snapcraft.io) → Login

#### Create snapcraft.yaml

File `snap/snapcraft.yaml`:

```yaml
name: pimankagom
base: core22
version: '1.0.0'
summary: Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
description: |
  Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ — Pimankagom, Pimaenkagom

grade: stable
confinement: strict

parts:
  pimankagom:
    plugin: flutter
    source: .
    flutter-target: lib/main.dart

apps:
  pimankagom:
    command: pimankagom
    extensions: [gnome]
    plugs:
      - network
      - home
```

#### Build and publish Snap

```bash
# Install snapcraft
sudo snap install snapcraft --classic

# Build snap
snapcraft

# Login
snapcraft login

# Upload
snapcraft upload pimankagom_1.0.0_amd64.snap --release=stable
```

---

### Option B: Flathub (Flatpak — widely supported)

Flathub is the largest Linux app platform, available on all major distributions.

**Prerequisites:**
- GitHub account
- Fork of the [Flathub repository](https://github.com/flathub/flathub)

#### Create app.pimankagom.json

```json
{
  "app-id": "app.pimankagom",
  "runtime": "org.freedesktop.Platform",
  "runtime-version": "23.08",
  "sdk": "org.freedesktop.Sdk",
  "command": "pimankagom",
  "finish-args": [
    "--share=network",
    "--socket=wayland",
    "--socket=fallback-x11",
    "--device=dri"
  ],
  "modules": [
    {
      "name": "pimankagom",
      "buildsystem": "simple",
      "build-commands": [
        "install -Dm755 pimankagom /app/bin/pimankagom",
        "cp -r lib /app/lib/pimankagom",
        "cp -r data /app/share/pimankagom"
      ],
      "sources": [
        {
          "type": "dir",
          "path": "build/linux/x64/release/bundle"
        }
      ]
    }
  ]
}
```

Submission: pull request to `flathub/flathub` with a dedicated repository for the app.

---

### Option C: AppImage (direct distribution, no installation required)

AppImage is a single file that runs on any Linux distribution without installation.

```bash
# Install appimagetool
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage

# Create AppDir structure
mkdir -p pimankagom.AppDir/usr/bin
cp -r build/linux/x64/release/bundle/* pimankagom.AppDir/usr/bin/

# .desktop file
cat > pimankagom.AppDir/pimankagom.desktop << EOF
[Desktop Entry]
Name=Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
Exec=pimankagom
Icon=pimankagom
Type=Application
Categories=Utility;
EOF

# Copy icon
cp assets/icon/icon.png pimankagom.AppDir/pimankagom.png

# Build AppImage
./appimagetool-x86_64.AppImage pimankagom.AppDir Pimankagom-x86_64.AppImage
```

The `Pimankagom-x86_64.AppImage` can be distributed directly.

---

### Option D: .deb Package (Debian/Ubuntu)

```bash
# Directory structure
mkdir -p pimankagom_1.0.0/DEBIAN
mkdir -p pimankagom_1.0.0/usr/lib/pimankagom
mkdir -p pimankagom_1.0.0/usr/bin
mkdir -p pimankagom_1.0.0/usr/share/applications
mkdir -p pimankagom_1.0.0/usr/share/icons/hicolor/256x256/apps

# Control file
cat > pimankagom_1.0.0/DEBIAN/control << EOF
Package: pimankagom
Version: 1.0.0
Architecture: amd64
Maintainer: Your Name <your@email.com>
Description: Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
 Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ — Pimankagom, Pimaenkagom
EOF

# Copy files
cp -r build/linux/x64/release/bundle/* pimankagom_1.0.0/usr/lib/pimankagom/
ln -s /usr/lib/pimankagom/pimankagom pimankagom_1.0.0/usr/bin/pimankagom
cp assets/icon/icon.png pimankagom_1.0.0/usr/share/icons/hicolor/256x256/apps/pimankagom.png

# Desktop file
cat > pimankagom_1.0.0/usr/share/applications/app.pimankagom.desktop << EOF
[Desktop Entry]
Name=Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ
Exec=/usr/lib/pimankagom/pimankagom
Icon=pimankagom
Type=Application
Categories=Utility;
EOF

# Build package
dpkg-deb --build pimankagom_1.0.0
```

---

## Checklist

- [ ] `flutter config --enable-linux-desktop` executed
- [ ] Build dependencies installed
- [ ] App name set in `my_application.cc` and `CMakeLists.txt`
- [ ] App icon set
- [ ] Version set in `pubspec.yaml`
- [ ] `flutter build linux --release` successful
- [ ] Distribution method chosen (Snap / Flatpak / AppImage / .deb)
- [ ] Package built and tested
- [ ] Published / uploaded
