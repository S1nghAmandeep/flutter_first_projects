import 'package:chat_app/utils.dart';
import 'package:flutter/material.dart';

class BottomInputBar extends StatefulWidget {
  const BottomInputBar({super.key});

  @override
  State<BottomInputBar> createState() => _BottomInputBarState();
}

class _BottomInputBarState extends State<BottomInputBar> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 340,
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: "Type tour message here",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            sendMessage(textEditingController.text);
            textEditingController.clear();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
