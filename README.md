# Chantons (Chantons Le Seigneur) 🎶

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux%20%7C%20Web-lightgrey?style=for-the-badge)](https://flutter.dev/multi-platform)

**Chantons** is a modern, cross-platform Christian hymnal and worship songbook application built with Flutter. Designed for personal devotion, church congregations, choir leaders, and worship teams, it provides quick access to hymns in both **Français (French)** and **Kreyòl Ayisyen (Haitian Creole)** with rich accessibility and customization options.

---

## ✨ Features

- 📖 **Bilingual Hymnal**: Browse Christian hymns and worship songs in French and Haitian Creole.
- 🔍 **Instant Search**: Search through songs rapidly by **number**, **title**, or **lyrics keywords**.
- 🌐 **Language Filtering**: Easily switch between French and Haitian Creole songbooks with localized UI (`AppLocalizations`).
- ✍️ **Custom Song Management (CRUD)**:
  - Add new songs directly to your local library.
  - Edit song lyrics, titles, and numbers.
  - Delete songs with a confirmation dialog.
- 👓 **Accessibility & Readability**:
  - **Dynamic Text Scaling**: Adjust font size on-the-fly for optimal reading distance and screen sizes.
  - **High Contrast Mode**: Toggle enhanced high-contrast visual theme for improved visibility in any lighting condition.
- 💾 **Offline First**: All songs are stored in a local SQLite database (`sqflite` / `sqflite_common_ffi`), seeded from structured JSON data (`assets/songs.json`). No active internet connection required during worship services.
- 🖥️ **True Multi-Platform**: Full native support for Mobile (Android, iOS), Desktop (Windows, macOS, Linux), and Web.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart SDK `^3.11.1`)
- **State Management**: [Provider](https://pub.dev/packages/provider) (`SettingsProvider`)
- **Database & Storage**:
  - [sqflite](https://pub.dev/packages/sqflite) & [sqflite_common_ffi](https://pub.dev/packages/sqflite_common_ffi) for cross-platform SQLite database persistence
  - [shared_preferences](https://pub.dev/packages/shared_preferences) for user preferences (text size, contrast theme, default language)
- **Design System**: Material 3 with customizable light/dark/high-contrast themes
- **Internationalization**: Custom localization system supporting:
  - 🇫🇷 French (`fr`)
  - 🇭🇹 Haitian Creole (`ht`)

---

## 📁 Project Structure

```text
chantons/
├── android/                   # Android native platform configuration
├── assets/                    # Static assets & seed database
│   └── songs.json             # Seed song catalog (French & Creole)
├── ios/                       # iOS native platform configuration
├── lib/
│   ├── localization/          # Custom localization (AppLocalizations)
│   │   └── app_localizations.dart
│   ├── models/                # Data models
│   │   └── song.dart          # Song model & serialization
│   ├── providers/             # State management
│   │   └── settings_provider.dart
│   ├── screens/               # UI Screens
│   │   ├── home_screen.dart   # Main song list & search view
│   │   ├── settings_screen.dart # Theme, language & text size settings
│   │   ├── song_edit_screen.dart # Add / edit song form
│   │   └── song_screen.dart   # Song lyrics display screen
│   ├── services/              # Business logic & services
│   │   └── database_helper.dart # SQLite database initialization & CRUD operations
│   └── main.dart              # Application entry point & theme configuration
├── linux/                     # Linux desktop configuration
├── macos/                     # macOS desktop configuration
├── test/                      # Unit and widget tests
├── web/                       # Web platform assets & configuration
├── windows/                   # Windows desktop configuration
└── pubspec.yaml               # Project dependencies and configuration
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.11.1`)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE with Flutter support ([VS Code](https://code.visualstudio.com/), [Android Studio](https://developer.android.com/studio), etc.)
- Platform toolchains (Android SDK for Android, Xcode for iOS/macOS, Visual Studio C++ build tools for Windows, etc.)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/roneldecius/chantons.git
   cd chantons
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   - For Default / Connected Device:
     ```bash
     flutter run
     ```
   - For Windows Desktop:
     ```bash
     flutter run -d windows
     ```
   - For Chrome / Web:
     ```bash
     flutter run -d chrome
     ```
   - For Android / iOS:
     ```bash
     flutter run -d <device_id>
     ```

---

## 🧪 Testing

Run automated tests using Flutter test runner:

```bash
flutter test
```

---

## 📦 Building for Production

To create a release build:

- **Android (APK)**:
  ```bash
  flutter build apk --release
  ```
- **Android (App Bundle)**:
  ```bash
  flutter build appbundle --release
  ```
- **Windows**:
  ```bash
  flutter build windows --release
  ```
- **Web**:
  ```bash
  flutter build web --release
  ```
- **iOS / macOS**:
  ```bash
  flutter build ipa --release
  flutter build macos --release
  ```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
