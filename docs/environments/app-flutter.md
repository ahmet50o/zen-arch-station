# Introduction

## Flutter
Flutter is an open-source UI software development kit created by Google. It is used to build natively compiled applications for mobile (Android, iOS), web, and desktop from a single codebase.

- **Language:** Uses Dart.
- **Rendering:** Instead of using system widgets, it uses its own high-performance rendering engine (Impeller/Skia).
- **Performance:** Code is compiled Ahead-of-Time (AOT) to native machine code, ensuring smooth 60fps/120fps performance.

## Components

### Flutter SDK
The core framework containing the Dart standard libraries and the Command Line Interface (CLI) for creating, testing, and compiling your applications.

### Android Command Line Tools (`cmdline-tools`)
A lightweight version of the Android development environment without the heavy Android Studio IDE.
- **sdkmanager:** A tool to download Android platform versions (APIs) and build tools.
- **build-tools:** Contains compilers like `d8` that transform your code into Android bytecode.

### Android Platform-Tools
Contains essential utilities for hardware communication:
- **ADB (Android Debug Bridge):** Allows you to install the final APK directly onto your phone and view real-time logs.

### Java Development Kit (JDK 17)
Android builds rely on Gradle (a Java-based build system). Flutter requires the JDK to manage the build process and package the APK files.

---

# Flutter Minimal Setup (Arch Linux) - API 36 - CLI Only

### 1. System Dependencies
```bash
sudo pacman -S --needed git unzip wget jdk17-openjdk
sudo archlinux-java set java-17-openjdk
```
* Installs base tools and sets Java 17 as the system default.

### 2. Directory Structure & Flutter
```bash
mkdir -p ~/sdk/android/cmdline-tools
cd ~/sdk
git clone [https://github.com/flutter/flutter.git](https://github.com/flutter/flutter.git) -b stable
```
* Installs SDKs in a dedicated directory, keeping your projects folder clean.

### 3. Android Command Line Tools
```bash
cd ~/sdk/android/cmdline-tools
wget [https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip](https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip)
unzip *.zip && rm *.zip
mv cmdline-tools latest
```
* **Important:** The `latest` folder is mandatory for the `sdkmanager` to find its own paths.

### 4. Environment Variables (ZSH)
Add these lines to the end of your `~/.zshrc`:
```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export ANDROID_HOME=$HOME/sdk/android
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$HOME/sdk/flutter/bin"
```
Reload configuration:
```bash
source ~/.zshrc
```

### 5. SDK 36 & Licenses
```bash
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
flutter doctor --android-licenses
flutter config --no-analytics
```
* Downloads Android platform data and opts out of telemetry.

### 6. Verification
```bash
flutter doctor
```
* "Android Studio not found" can be ignored; "Android toolchain" must show a checkmark.

---

## Workflow: Building the APK
```bash
cd ~/projects
flutter create my_project
cd my_project
flutter build apk --release
```
* **Location:** `build/app/outputs/flutter-apk/app-release.apk`.

---

## Maintenance
* **Update:** `flutter upgrade && sdkmanager --update`
* **Clean Project:** `flutter clean`
* **Clear Caches (Disk Space):** `rm -rf ~/.gradle ~/.pub-cache`
* **Check Java:** `archlinux-java status`

## Complete Uninstallation
```bash
rm -rf ~/sdk/flutter ~/sdk/android ~/.gradle ~/.pub-cache ~/.config/flutter ~/.android
# Manually remove export lines from ~/.zshrc.
```