import 'dart:async';
import 'dart:io';
import 'package:clock_app/constants.dart';
import 'package:clock_app/top_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:clock_app/bottom_nav.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.title});

  final String title;

  @override
  State<TimerScreen> createState() {
    return _TimerScreenState();
  }
}

class _TimerScreenState extends State<TimerScreen> {
  List<int> numbers = [];
  String displayString = "";
  int digitsEntered = 0;
  List<int> originalNumbersList = [];
  Timer timer = Timer(const Duration(seconds: 0), () {});
  late int h;
  late int m;
  late int s;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    updateTimerDisplay();
  }

  void handleNumberButtonClicked(int number) {
    if (digitsEntered < MAX_SIZE) {
      numbers.removeAt(0);
      numbers.add(number);
      updateTimerDisplay();
      digitsEntered++;
    }
  }

  String getHours() {
    if (h < 10) {
      return "0${h}h";
    } else {
      return "${h}h";
    }
  }

  String getMinutes() {
    if (m < 10) {
      return "0${m}m";
    } else {
      return "${m}m";
    }
  }

  String getSeconds() {
    if (s < 10) {
      return "0${s}s";
    } else {
      return "${s}s";
    }
  }

  void handleSpecialButtonClicked(String key) {
    switch (key) {
      case "00":
        if (digitsEntered + 1 < MAX_SIZE) {
          numbers.removeAt(0);
          numbers.add(0);
          numbers.removeAt(0);
          numbers.add(0);
          digitsEntered += 2;
        }
        break;
      case "delete":
        if (digitsEntered > 0) {
          numbers.removeLast();
          digitsEntered--;
        }
        break;
      case "reset":
        for (int i = 0; i < originalNumbersList.length; i++) {
          numbers[i] = originalNumbersList[i];
          updateTimerDisplay();
        }
        break;
      case "start":
        for (int i = 0; i < numbers.length; i++) {
          originalNumbersList.add(numbers[i]);
        }
        int hours = int.parse("${numbers[0]}${numbers[1]}");
        int minutes = int.parse("${numbers[2]}${numbers[3]}");
        int seconds = int.parse("${numbers[4]}${numbers[5]}");
        duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
        timer = Timer.periodic(const Duration(seconds: 1), (timer) => update());
        break;
      case "clear":
        numbers.clear();
        digitsEntered = 0;
        break;
    }
    updateTimerDisplay();
  }

  void updateTimerDisplay() {
    setState(() {
      for (var i = numbers.length; i < MAX_SIZE; i++) {
        numbers.insert(0, 0);
      }
      displayString =
          "${numbers[0]}${numbers[1]}h ${numbers[2]}${numbers[3]}m ${numbers[4]}${numbers[5]}s";
    });
  }

  void update() {
    int updateSecondsValue = duration.inSeconds - 1;
    duration = Duration(seconds: updateSecondsValue);
    if (duration.inSeconds <= 0) {
      if (Platform.isAndroid || Platform.isIOS) {
        FlutterRingtonePlayer().playNotification(volume: volume);
      }
      timer.cancel();
    }
    h = (duration.inSeconds / SECONDS_IN_ONE_HOUR).floor();
    m = ((duration.inSeconds % SECONDS_IN_ONE_HOUR) / SECONDS_IN_ONE_MINUTE)
        .floor();
    s = ((duration.inSeconds % SECONDS_IN_ONE_MINUTE)).floor();

    setState(() {
      displayString = "${getHours()} ${getMinutes()} ${getSeconds()}";
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return Expanded(
      child: CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopNavigationBar(),
        Expanded(
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  displayString,
                  style: const TextStyle(
                    fontSize: 40,
                    color: CupertinoColors.white,
                  ),
                ),
                const Spacer(),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 2,
                  ),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      return buildButton(
                        text: "${index + 1}",
                        onPressed: () {
                          handleNumberButtonClicked(index + 1);
                        },
                      );
                    } else if (index == 9) {
                      return buildButton(
                        text: "00",
                        onPressed: () {
                          handleSpecialButtonClicked("00");
                        },
                      );
                    } else if (index == 10) {
                      return buildButton(
                        text: "0",
                        onPressed: () {
                          handleNumberButtonClicked(0);
                        },
                      );
                    } else if (index == 11) {
                      return buildButton(
                        text: "<",
                        onPressed: () {
                          handleSpecialButtonClicked("delete");
                        },
                      );
                    } else if (index == 12) {
                      return Expanded(
                        child: CupertinoButton.filled(
                          child: const Icon(CupertinoIcons.refresh_thin),
                          onPressed: () {
                            handleSpecialButtonClicked("refresh");
                          },
                        ),
                      );
                      } else if (index == 13) {
                      return Expanded(
                        child: CupertinoButton.filled(
                          child: const Icon(CupertinoIcons.play),
                          onPressed: () {
                            handleSpecialButtonClicked("start");
                          },
                        ),
                      );
                    } else {
                      return buildButton(
                        text: "C",
                        onPressed: () {
                          handleSpecialButtonClicked("clear");
                        },
                      );
                    }
                  },
                ),
               
              ],
            ),
          ),
        ),
        const AppBottomNavigationBar(),
      ],
    );
  }
}
