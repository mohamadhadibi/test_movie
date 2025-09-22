# Test Movie - Flutter Challenge

## Architecture
Clean Architecture with BLoC pattern for state management.

## Technical Decisions
- **BLoC**: Predictable state management, easy testing
- **Clean Architecture**: Separation of concerns, maintainability
- **Shared Preferences**: Simple local storage for favorites
- **tmdb_api**: Lightweight API wrapper for TMDB api calls handling
- **gen_lang**: For text localization (in spite of only en we support in this app)
- **infinite_scroll_pagination**: for better endless scrollview handling

## Getting Started
1. Get TMDB API key from https://www.themoviedb.org/settings/api
2. Add API key to `lib/core/utils/api_constants.dart`
3. Run `flutter pub get`
4. Run `flutter run`

## Running Tests
- Unit tests: `flutter test`
- Widget tests: `flutter test test/widget_test.dart`