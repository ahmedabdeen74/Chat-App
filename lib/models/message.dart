import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  Message({required this.id,required this.message});
  factory Message.fromjeson(jesonData) {
    return Message(message: jesonData[kMessage],id: jesonData[kId]);
  }
}
