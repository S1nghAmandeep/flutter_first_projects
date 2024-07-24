import 'package:chat_app/chat_room.dart';
import 'package:chat_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pubnub/pubnub.dart';

void main() {
  runApp(const MyApp());
  final myKeyset =
      Keyset(subscribeKey: 'demo', publishKey: 'demo', userId: const UserId('demo'));
  pubNub = PubNub(defaultKeyset: myKeyset);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showJoinChatRoomDialog());
  }

  void showJoinChatRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
          child: Text('Join chat room'),
        ),
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                    hintText: 'Input your name', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: SizedBox(
              child: ElevatedButton(
                child: const Text('Join'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    username = userNameController.text;
                    navigateToChatRoomScreen();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateToChatRoomScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChatRoomScreen(title: "Chat Room"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(),
    );
  }
}
