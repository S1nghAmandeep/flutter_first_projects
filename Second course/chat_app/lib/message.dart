import 'package:chat_app/event.dart';
import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';
import 'package:chat_app/globals.dart';
import 'package:chat_app/utils.dart';

class Message extends StatefulWidget {
  Message({
    super.key,
    this.messageText = "",
    required this.username,
    this.likeCount = 0,
    required this.timetoken,
    this.replyCount = 0,
    required this.index,
  });

  String messageText;
  final String username;
  int likeCount;
  final Timetoken timetoken;
  int replyCount;
  final int index;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late Color color;
  late double scaleX;
  late Alignment alignment;
  late Alignment textAlignment;
  late String prefix;
  late bool isUserPost;
  late Color textColor;
  late String likeCountText;
  late Icon icon1;
  late double widthOfSpaceBeforeIcons;
  late String replyCountText;
  late Icon icon2;

  TextEditingController replyToMessageController = TextEditingController();
  TextEditingController editMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUserPost = username == widget.username;
    color = isUserPost ? Colors.green : Colors.blue;
    scaleX = isUserPost ? -1 : 1;
    textColor = Colors.white;
    updateLikes(widget.likeCount);
    alignment = isUserPost ? Alignment.bottomRight : Alignment.bottomLeft;
    textAlignment = isUserPost ? Alignment.topLeft : Alignment.topLeft;
    prefix = isUserPost
        ? "\n\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
        : "\n\n\n\t";
    likeCountText = isUserPost ? "" : widget.likeCount.toString();
    widthOfSpaceBeforeIcons = isUserPost ? 10 : 105;
    replyCountText = isUserPost ? "" : widget.replyCount.toString();
    icon2 = isUserPost ? const Icon(Icons.edit) : const Icon(Icons.reply);
  }

  void showEditMessageDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(
                child: Text('Edit Message'),
              ),
              content: SizedBox(
                height: 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: editMessageController,
                    )
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      // sendMessage(replyToMessageController.text);
                      setState(() {
                        widget.messageText = editMessageController.text;
                        // editMessageController.text = '';
                      });
                      pubNub.addMessageAction(
                        type: "edited",
                        value: editMessageController.text,
                        channel: channelValue,
                        timetoken: widget.timetoken,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                )
              ],
            ));
  }

  void showReplyToMessageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text('Reply to message'),
            ),
            content: SizedBox(
              width: 300,
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: replyToMessageController,
                  )
                ],
              ),
            ),
            actions: [
              SizedBox(
                child: ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    sendMessage(replyToMessageController.text);
                    setState(() {
                      replyToMessageController.text = '';
                      widget.replyCount++;
                      replyCountText = widget.replyCount.toString();
                    });
                    pubNub.addMessageAction(
                      type: "replied",
                      value: widget.replyCount.toString(),
                      channel: channelValue,
                      timetoken: widget.timetoken,
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              )
            ],
          );
        });
  }

  void updateLikes(int numberOfLikes) {
    setState(() {
      if (isUserPost) {
        icon1 = const Icon(Icons.delete);
      } else {
        if (widget.likeCount > 0) {
          icon1 = const Icon(
            Icons.thumb_up,
            color: Colors.black,
          );
          textColor = Colors.black;
        } else {
          icon1 = const Icon(Icons.thumb_up_outlined);
          textColor = Colors.white;
        }
      }
    });
  }

  void showDeleteMessageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text('Are you sure you wanr to delete this message'),
            ),
            content: const SizedBox(
              height: 60,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
            actions: [
              SizedBox(
                child: ElevatedButton(
                  child: const Text(
                    'Delete Message',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      eventBus.fire(DeleteMesseageEvent(widget.index));
                      pubNub.addMessageAction(
                          type: 'deleted',
                          value: ".",
                          channel: channelValue,
                          timetoken: widget.timetoken);
                    });
                  },
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 400,
        height: 200,
        child: Transform.scale(
          scaleX: scaleX,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/message.png',
                color: color,
              ),
              Transform.scale(
                scaleX: scaleX,
                child: Align(
                  alignment: textAlignment,
                  child: Text(
                    "$prefix${widget.messageText}",
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: widthOfSpaceBeforeIcons,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 115,
                      ),
                      Text(
                        likeCountText,
                        style: TextStyle(color: textColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      IconButton(
                        onPressed: () {
                          if (isUserPost) {
                            showDeleteMessageDialog();
                          } else {
                            widget.likeCount++;
                            updateLikes(widget.likeCount);
                            setState(() {
                              likeCountText = widget.likeCount.toString();
                            });
                            pubNub.addMessageAction(
                                type: "liked",
                                value: widget.likeCount.toString(),
                                channel: channelValue,
                                timetoken: widget.timetoken);
                          }
                        },
                        icon: icon1,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 115,
                      ),
                      Text(replyCountText),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      IconButton(
                        onPressed: () {
                          if (isUserPost) {
                            editMessageController.text = widget.messageText;
                            showEditMessageDialog();
                          } else {
                            showReplyToMessageDialog();
                          }
                        },
                        icon: icon2,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
