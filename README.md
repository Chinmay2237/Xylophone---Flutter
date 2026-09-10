# 📰 Briefly — Production-Grade Flutter News Application

[![Flutter](https://img.shields.io/badge/Flutter-%5E3.11.5-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%5E3.11-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20Provider-42A5F5?style=for-the-badge)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.style=for-the-badge)](LICENSE)
[![Security](https://img.shields.io/badge/Security-Production--Ready-brightgreen?style=for-the-badge&logo=shield)](SECURITY.md)

> **Briefly** is a polished, production-ready Flutter news application built using **Clean Architecture**, **Provider**, **Dio**, **GoRouter**, and **Material 3**. Designed for performance, fluid animations, responsive layouts, and robust client-side security.

---

## ✨ Features

- 📰 **Headlines Feed**: Real-time breaking headlines with country selection and topic chip filtering.
- ⚡ **Shimmer Skeleton Loading**: Custom animated shimmer placeholders (`NewsCardSkeleton`) for a premium loading experience.
- 🔄 **Infinite Scroll Pagination**: Automatic background load-more pagination on scroll threshold.
- 🔍 **Debounced Live Search**: Instant auto-search while typing (400ms debounce) with recent search history persistence and clear-all controls.
- 🔖 **Bookmarks Management**: Save articles for offline reading, featuring swipe-to-delete with an **Undo SnackBar** and "Clear all" options.
- 🎨 **Adaptive Theme & Typography**: Light/Dark theme switching and interactive Segmented text scaling (Small, Normal, Large, X-Large).
- 📱 **Responsive Adaptive UI**: Responsive center layout supporting Mobile (`<600px`), Tablet (`600–900px`), and Desktop/Web (`>900px`) with `NavigationRail` and `NavigationBar`.
- 🚀 **Hero Animations**: Smooth image and content hero transitions between news cards and story detail pages.

---

## 🔒 Security & Production Key Safety

To ensure your API keys and production backends remain **100% secure**, Briefly enforces strict key management and data protection rules:

### 1. Zero Hardcoded Credentials
- No API keys, tokens, or private secrets are ever stored in source code or committed to Git version control.
- `.env` and `.env.*` files are explicitly ignored in `.gitignore`.

### 2. Environment Configuration Options
Briefly reads the `NEWS_API_KEY` dynamically through three fallback layers:
1. **Compile-Time Definition**: `--dart-define=NEWS_API_KEY=your_key` or `--dart-define-from-file=.env` (Recommended).
2. **System Environment Variable**: `Platform.environment['NEWS_API_KEY']` (Desktop & CI/CD).
3. **Local Development Asset**: `.env` file (Ignored from Git).

### 3. Web Production Proxy Architecture (CORS & Key Shielding)
> [!IMPORTANT]
> Calling external API services directly from browser code can expose API keys in browser developer tools (Network tab) and trigger CORS blocks.

For deployed Web releases:
- Use `NEWS_API_BASE_URL` to route requests through a secure backend proxy (e.g. Cloudflare Worker, Vercel Edge, AWS Lambda).
- The proxy server attaches the `apikey` server-side so client-side browser bundles never expose the key.

### 4. Automatic Sensitive Log Redaction
- All network exception handlers sanitize output to redact `apikey` query parameters from stack traces and user-facing error dialogs (`apikey=***redacted***`).

---

## 🏗 Architecture & Project Structure

Briefly follows **Clean Architecture** principles with a feature-first modular folder layout:

```text
lib/
├── core/
│   ├── config/          # Environment & dynamic API configuration (IO & Stub)
│   ├── constants/       # App-wide color palette, breakpoints, and constants
│   ├── error/           # Exception definitions & network error mapping
│   ├── network/         # Dio HTTP client configuration & interceptors
│   ├── router/          # GoRouter navigation & route configuration
│   ├── services/        # Local persistent storage (SharedPreferences)
│   ├── theme/           # Material 3 light/dark theme design system
│   └── widgets/         # Reusable core widgets (AppShell, BrieflyLogo, ArticleImage)
│
└── features/
    ├── home/            # News feed, detail page, and news card skeletons
    ├── search/          # Search provider, history, and search page UI
    ├── bookmarks/       # Saved stories provider & bookmarks UI
    └── settings/        # Theme switcher, font scaler, and country picker
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `>=3.11.5`
- **Dart SDK**: `>=3.11`
- A free API key from [GNews.io](https://gnews.io)

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/briefly.git
   cd briefly
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables:**
   Create a `.env` file in the root directory by copying `.env.example`:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and paste your GNews API key:
   ```ini
   NEWS_API_KEY=your_actual_gnews_api_key
   ```

---

## 🏃 Running the Application

### Mobile & Desktop (Android, iOS, macOS, Linux, Windows)
```bash
flutter run --dart-define-from-file=.env
```

### Web Development (Localhost)
```bash
flutter run -d chrome --dart-define-from-file=.env
```

### Web Production Release Build
```bash
flutter build web --release --dart-define-from-file=.env
```

---

## 🧪 Testing & Quality Assurance

Briefly maintains high engineering standards with 100% passing unit and widget tests:

```bash
# 1. Format code according to Dart guidelines
dart format .

# 2. Perform static analysis (0 errors, 0 warnings)
flutter analyze

# 3. Execute unit and widget test suite
flutter test
```

### Automated Test Coverage
- **`HomeProvider`**: Initial loading, category filtering, infinite pagination, error handling.
- **`SearchProvider`**: Query searching, result clearing, history persistence.
- **`BookmarkProvider`**: Adding, removing, checking presence, and clearing offline bookmarks.
- **`Widget Verification`**: `BrieflyLogo`, `CategoryChip`, and core UI components.

---

## 🛡 Security Vulnerability Reporting

If you discover a potential security issue, please read [SECURITY.md](SECURITY.md) for reporting guidelines. Do not open public issues containing API keys, private tokens, or crash dumps.

---

## 📄 License & Copyright

Source code and UI architecture are available under the **MIT License**. Third-party news content and headlines belong to their respective publishers via GNews. See [LICENSE](LICENSE) and [NOTICE](NOTICE) for details.
