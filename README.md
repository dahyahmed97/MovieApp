#  Movie App 🎬

This is the ** Movie App**, a movie browsing app built with **Flutter** that integrates the **TMDB API** for fetching movie data. The app supports dark mode, search functionality, and stores user favorites locally. It also ensures **network connectivity checks** using `data_connection_checker_nulls`.

---

## 🚀 Features
- Browse latest movies.
- Search for movies with real-time results.
- Add movies to your favorites.
- Toggle between **light** and **dark** themes.
- Network monitoring .

---

## 🛠️ Setup Instructions

Follow these steps to run the project locally:

### 1. Prerequisites
Make sure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.x or higher)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) for emulators.
- A device or emulator to run the app.

### 2. Clone the Repository
```bash
git clone https://github.com/your-username/fh-movie-app.git
cd fh-movie-app
```

### 3. Install Dependencies
Run the following command to install the required packages:
```bash
flutter pub get
```

### 4. Configure API Key
the api key is hard coded for now


### 5. Running the App
1. Start an emulator or connect your device.
2. Run the following command:
   ```bash
   flutter run
   ```
3. If you encounter issues with connectivity, make sure to allow network permissions in:
   - **Android**: Add the following to `AndroidManifest.xml`:
     ```xml
     <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
     <uses-permission android:name="android.permission.INTERNET" />
     ```
   - **iOS**: Add the following to `Info.plist`:
     ```xml
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
     ```

---

## 📋 Assumptions
1. The user has basic knowledge of Flutter development and package management.
2. The app relies on **TMDB API** for data, so a valid **API key** is required.
3. The device or emulator must have internet access to fetch movie data.

---

## 🧪 Running Unit Tests
We’ve included unit tests for the app logic to ensure everything runs as expected.

### Run All Tests
To run the unit tests, use:
```bash
flutter test
```

### Test Coverage
1. Make sure you have the `flutter_test` package included in your `pubspec.yaml`.
2. Optionally, install `lcov` for generating code coverage reports:
   ```bash
   brew install lcov   # For Mac
   sudo apt-get install lcov  # For Linux
   ```
3. To generate a code coverage report, run:
   ```bash
   flutter test --coverage
   genhtml coverage/lcov.info -o coverage/html
   open coverage/html/index.html
   ```

---
