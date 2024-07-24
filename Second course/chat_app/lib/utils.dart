import 'package:chat_app/globals.dart';

void sendMessage(String message) async {
  await pubNub
      .publish(channelValue, {'message': message, 'username': username});
}
