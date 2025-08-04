# Flutter Notes App

## 📁 App Structure

The app follows a clean structure with these main components:

### Models

- `note.dart` - Defines the Note data model with Hive annotations
- `note.g.dart` - Auto-generated Hive adapter for the Note model

### Screens

- `home_screen.dart` - Main screen showing list of notes
- `add_note_screen.dart` - Screen for adding new notes
- `note_detail_screen.dart` - Screen for viewing/editing notes

### Main files

- `main.dart` - App entry point and theme management

## ✨ Features

### Note Management

- ✅ Create new notes with title and content
- ✏️ Edit existing notes
- 🗑️ Delete notes (single or multiple)
- 📌 Pin/unpin important notes (pinned notes appear first)

### User Interface

- 🎨 Clean Material Design interface
- 🌓 Dark/Light/System theme options
- 📱 Responsive layout for all screen sizes
- 🔄 Intuitive note sorting (pinned first, then by date)

### Data Persistence

- 💾 Uses Hive for fast local storage
- 🔄 Notes are saved between app sessions
- 🌗 Theme preference is remembered

### Multi-selection

- 👆 Long-press notes to enter selection mode
- ✔️ Select multiple notes to pin/unpin or delete
- 👀 Visual feedback for selected notes

## 🚀 How to Run the App

### Prerequisites

- Flutter SDK installed
- Android Studio/VSCode with Flutter plugin
- Android emulator or physical device

### Setup

1. Run `flutter pub get` to install dependencies
2. For Hive code generation, run:
   ```bash
   flutter packages pub run build_runner build
   ```

### Running the app:

1. Connect your device/emulator
2. Run `flutter run` in the project directory
3. Or use your IDE's run/debug options (eg. "F5 on VSCode")

## 🛠️ Technical Details

- State Management: Uses built-in Flutter state management (setState)
- Database: Hive (lightweight NoSQL database)
- Dependencies:
  - hive & hive_flutter: For local storage
  - intl: For date formatting

## ♻️ Future Improvements

1. 📂 Add note categories/tags
2. 🔍 Implement note search functionality
3. 🔠 Add rich text formatting options
4. ☁️ Cloud sync capability
5. 🔗 Note sharing options

### 🐝 For Hive-related issues:

- Ensure you've run the `build_runner` command
- Verify all boxes are opened in `main.dart`

## App Preview
![alt text](assets/app%20preview/Screenshot_1754335694.png)![alt text](assets/app%20preview/Screenshot_1754336016.png)![alt text](assets/app%20preview/Screenshot_1754335738.png)![alt text](assets/app%20preview/Screenshot_1754335743.png)