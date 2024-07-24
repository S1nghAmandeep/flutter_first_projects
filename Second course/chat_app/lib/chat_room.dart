import 'package:chat_app/event.dart';
import 'package:chat_app/globals.dart';
import 'package:chat_app/input.dart';
import 'package:chat_app/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pubnub/pubnub.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

late Subscription subscription;

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  List<Message> messages = [];
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    subscription.unsubscribe();
  }

  @override
  void initState() {
    super.initState();
    subscription = pubNub.subscribe(channels: {channelValue});
    subscription.messages.listen((m) {
      setState(() {
        if (m.content['message'] != null) {
          Message message = Message(
            username: m.content['username'],
            messageText: m.content['message'],
            timetoken: m.publishedAt,
            index: messages.length,
          );
          messages.add(message);
        }
      });
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });

    var result = pubNub.batch
        .fetchMessages({channelValue}, count: 8, includeMessageActions: true);
    result.then((batchHistoryResult) {
      setState(() {
        if (batchHistoryResult.channels[channelValue] != null) {
          List<BatchHistoryResultEntry> historyResults = batchHistoryResult
              .channels[channelValue] as List<BatchHistoryResultEntry>;
          historyResults.forEach((element) async {
            int i = 0;
            String editedMessage = element.message['message'];
            if (element.actions != null &&
                element.actions!.keys.contains("deleted")) {
            } else {
              bool hasLikes = element.actions != null &&
                  element.actions!.keys.contains("linked");
              bool hasReplies = element.actions != null &&
                  element.actions!.keys.contains("replied");
              bool hasBeenEdited = element.actions != null &&
                  element.actions!.keys.contains("edited");
              int likes = 0;
              int replies = 0;
              if (hasLikes) {
                List<int> likesAsInts = [];
                element.actions?["linked"].keys.forEach((s) {
                  likesAsInts.add(int.parse(s));
                });
                likesAsInts.sort();
                likes = likesAsInts[likesAsInts.length - 1];
              }
              if (hasReplies) {
                List<int> repliesAsInts = [];
                element.actions?["replied"].keys.forEach((s) {
                  repliesAsInts.add(int.parse(s));
                });
                repliesAsInts.sort();
                replies = repliesAsInts[repliesAsInts.length - 1];
              }
              if (hasBeenEdited) {
                int latestTime = 0;
                Map<int, String> timestampsAndEdits = Map();
                element.actions!['edited'].forEach((key, value) {
                  int timestamp = int.parse(value[0]['actionTimetoken']);
                  timestampsAndEdits[timestamp] = key;
                  if (timestamp > latestTime) {
                    latestTime = timestamp;
                  }
                });
                editedMessage = timestampsAndEdits[latestTime].toString();
              }
              messages.add(
                Message(
                  username: element.message['username'],
                  messageText: editedMessage,
                  // messageText: element.message['message'],
                  timetoken: element.timetoken,
                  replyCount: replies,
                  index: i,
                ),
              );
            }
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
          });
        }
      });
    });

    eventBus.on<DeleteMesseageEvent>().listen((event) {
      setState(() {
        messages.removeAt(event.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: const BottomInputBar(),
      body: ListView(
        controller: scrollController,
        children: [
          Column(
            children: messages,
          ),
        ],
      ),
    );
  }
}
