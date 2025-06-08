import 'chat_controller.dart';

class AppController {
  static final AppController instance = AppController._internal();
  late final ChatController chatController;

  AppController._internal() {
    chatController = ChatController();
  }
}
