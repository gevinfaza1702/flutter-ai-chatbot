# AI Chatbot Flutter App

A simple Flutter application demonstrating an MVC structure for an AI Chatbot similar to ChatGPT. The app now connects to the OpenAI API for real responses.

## Features
- Splash screen and basic authentication screens.
- Home page with chat history.
- Chat page with OpenAI powered responses.
- Profile, Settings and Help pages.
- Bottom navigation for quick access.

## Structure
```
lib/
  models/        # data models
  controllers/   # app logic and HTTP requests
  views/         # UI pages
  components/    # reusable widgets
```

Run `flutter pub get` and then `flutter run` to launch the application.

### OpenAI API Key

Create a new file at `lib/config/api_config.dart` and place your OpenAI API key in it:

```dart
const String openAIApiKey = 'YOUR_API_KEY_HERE';
```

This key will be used by `ChatController` to request responses from the ChatGPT API.
