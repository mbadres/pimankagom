# Deployment: Web (Flutter Web)

## Prerequisites

- Flutter SDK with web support: `flutter config --enable-web`
- `flutter doctor` shows no web errors
- Hosting service (see options below)
- Optional: custom domain

---

## 1. App Identity on the Web

| Field | Value | File |
|---|---|---|
| Page title (tab) | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ | [web/index.html](../web/index.html) |
| Web app name | Ⲡⲓⲙⲁⲛ̀ⲕⲁϫⲱⲙ | [web/manifest.json](../web/manifest.json) |
| Short name (home screen) | pimankagom | [web/manifest.json](../web/manifest.json) |
| URL | `https://pimaenkagom.app` or any other | — |

---

## 2. Replace Favicon and Web Icons

Replace the following files in `web/`:

| File | Size | Usage |
|---|---|---|
| `favicon.png` | 16×16 or 32×32 px | Browser tab |
| `icons/Icon-192.png` | 192×192 px | Android home screen |
| `icons/Icon-512.png` | 512×512 px | Splash screen |
| `icons/Icon-maskable-192.png` | 192×192 px | Android (adaptive) |
| `icons/Icon-maskable-512.png` | 512×512 px | Android (adaptive) |

---

## 3. Create Release Build

```bash
flutter build web --release
```

Output:
```
build/web/
```

### Options

```bash
# With base href (when app is not served from root)
flutter build web --release --base-href /pimankagom/

# With web renderer (canvaskit = higher quality, larger; html = smaller, faster)
flutter build web --release --web-renderer canvaskit
flutter build web --release --web-renderer html
```

---

## 4. Hosting Options

### Option A: Firebase Hosting (recommended)

**Prerequisites:** Google account, [Firebase CLI](https://firebase.google.com/docs/cli)

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize project (in project directory)
firebase init hosting
# → Public directory: build/web
# → Single-page app: Yes
# → Overwrite index.html: No

# Deploy
firebase deploy --only hosting
```

Result: `https://PROJECTNAME.web.app`

Custom domain: Firebase Console → Hosting → Add domain

---

### Option B: GitHub Pages (free)

1. Create repository on GitHub
2. Push `build/web/` contents to branch `gh-pages`:

```bash
flutter build web --release --base-href /REPO-NAME/
# Push contents of build/web/ to gh-pages branch
```

3. Repository settings → Pages → Branch: `gh-pages`

Result: `https://USERNAME.github.io/REPO-NAME/`

---

### Option C: Netlify

1. [netlify.com](https://www.netlify.com) → Add new site → Deploy manually
2. Drag & drop the `build/web/` folder
3. Optional: add custom domain in Netlify settings

Automatic deployment via Git:
- Build command: `flutter build web --release`
- Publish directory: `build/web`

---

### Option D: Own Server / VPS

```bash
# Copy build/web/ to server, e.g. via scp
scp -r build/web/* user@server:/var/www/pimankagom/

# Nginx configuration (single-page app)
server {
    listen 80;
    server_name pimaenkagom.app;
    root /var/www/pimankagom;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

---

## 5. HTTPS

Flutter Web **requires HTTPS** for many features (e.g. camera, geolocation, service worker).

- Firebase Hosting: HTTPS automatic
- GitHub Pages: HTTPS automatic
- Netlify: HTTPS automatic
- Own server: Let's Encrypt via Certbot

```bash
# Let's Encrypt on Ubuntu/Debian
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d pimaenkagom.app
```

---

## 6. Progressive Web App (PWA)

The app already supports PWA via `manifest.json`. Users can add the app to their home screen.

For full offline support: the service worker in `web/flutter_service_worker.js` is generated automatically by Flutter — no manual changes needed.

---

## 7. Domain Setup (`pimaenkagom.app`)

1. Purchase domain from a registrar (e.g. Namecheap, IONOS, Google Domains)
2. Set DNS record at the registrar:
   - **A record**: `@` → server IP address
   - **CNAME**: `www` → `pimaenkagom.app`
   - For Firebase/Netlify: use the DNS records shown there
3. Activate SSL certificate (usually automatic with hosting service)

---

## Checklist

- [ ] `flutter config --enable-web` executed
- [ ] Favicon and icons replaced
- [ ] `manifest.json` and `index.html` correctly filled in
- [ ] `flutter build web --release` successful
- [ ] Hosting service chosen and set up
- [ ] `build/web/` deployed
- [ ] HTTPS active
- [ ] Domain configured (optional)
- [ ] PWA tested on mobile device (home screen installation)
