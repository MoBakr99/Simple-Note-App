# Flutter Notes App - README

## App Structure
The app follows a clean structure with these main components:

1. Models:
   - note.dart: Defines the Note data model with Hive annotations
   - note.g.dart: Auto-generated Hive adapter for the Note model

2. Screens:
   - home_screen.dart: Main screen showing list of notes
   - add_note_screen.dart: Screen for adding new notes
   - note_detail_screen.dart: Screen for viewing/editing notes

3. Main files:
   - main.dart: App entry point and theme management

## Features

1. Note Management:
   - Create new notes with title and content
   - Edit existing notes
   - Delete notes (single or multiple)
   - Warning before deleting any note
   - Pin/unpin important notes (pinned notes appear first)

2. User Interface:
   - Clean Material Design interface
   - Dark/Light/System theme options
   - Responsive layout for all screen sizes
   - Intuitive note sorting (pinned first, then by date)

3. Data Persistence:
   - Uses Hive for fast local storage
   - Notes are saved between app sessions
   - Theme preference is remembered

4. Multi-selection:
   - Long-press notes to enter selection mode
   - Select multiple notes to pin/unpin or delete
   - Visual feedback for selected notes

## How to Run the App

1. Prerequisites:
   - Flutter SDK installed
   - Android Studio/VSCode with Flutter plugin
   - Android emulator or physical device

2. Setup:
   - Run `flutter pub get` to install dependencies
   - For Hive code generation, run:
     `flutter packages pub run build_runner build`

3. Running the app:
   - Connect your device/emulator
   - Run `flutter run` in the project directory
   - Or use your IDE's run/debug options (eg. "F5 on VSCode")

4. First Use:
   - The app will create necessary Hive boxes automatically
   - No initial setup required

## Technical Details

- State Management: Uses built-in Flutter state management (setState)
- Database: Hive (lightweight NoSQL database)
- Dependencies:
  - hive & hive_flutter: For local storage
  - intl: For date formatting

## Future Improvements

1. Add note categories/tags
2. Implement note search functionality
3. Add rich text formatting options
4. Cloud sync capability
5. Note sharing options

For Hive-related issues:
- Ensure you've run the build_runner command
- Verify all boxes are opened in main.dart