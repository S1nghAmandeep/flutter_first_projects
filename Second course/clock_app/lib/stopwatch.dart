import 'dart:async';

import 'package:clock_app/bottom_nav.dart';
import 'package:clock_app/constants.dart';
import 'package:clock_app/top_nav.dart';
import 'package:flutter/cupertino.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _StopwatchScreenState();
  }
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  Stopwatch stopwatch = Stopwatch();
  bool isRunning = false;
  IconData icons = CupertinoIcons.play_rectangle;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(milliseconds: 1), (timer) => update());
  }

  void start() {
    isRunning = true;
    stopwatch.start();
  }

  void pause() {
    isRunning = false;
    stopwatch.stop();
  }

  void reset() {
    pause();
    stopwatch.reset();
  }

  String getMinutes() {
    if (minutes < 10) {
      return "0$minutes";
    } else {
      return minutes.toString();
    }
  }

  String getSeconds() {
    if (seconds < 10) {
      return "0$seconds";
    } else {
      return seconds.toString();
    }
  }

  String getMilliseconds() {
    if (milliseconds < 10) {
      return "0$milliseconds";
    } else {
      return milliseconds.toString();
    }
  }

  void update() {
    setState(() {
      minutes =
          (stopwatch.elapsedMilliseconds / MICROSECONDS_IN_ONE_MINUTE).floor();
      seconds = ((stopwatch.elapsedMilliseconds % MICROSECONDS_IN_ONE_MINUTE) /
              MICROSECONDS_IN_ONE_SECOND)
          .floor();
      milliseconds =
          ((stopwatch.elapsedMicroseconds % MICROSECONDS_IN_ONE_MILLISECOND) /
                  10000)
              .floor();
      isRunning = stopwatch.isRunning;
      icons = isRunning
          ? CupertinoIcons.pause_rectangle
          : CupertinoIcons.play_rectangle;
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopNavigationBar(),
        Expanded(
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00:${getMinutes()}:${getSeconds()}",
                    style: const TextStyle(
                      fontSize: 70,
                      color: CupertinoColors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5),
                    child: Text(
                      getMilliseconds(),
                      style: const TextStyle(
                        fontSize: 30,
                        color: CupertinoColors.white,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.refresh_thin),
                    onPressed: () {
                      stopwatch.reset();
                    },
                  ),
                  CupertinoButton(
                    child: Icon(
                      icons,
                      size: 100,
                    ),
                    onPressed: () {
                      if (stopwatch.isRunning) {
                        pause();
                      } else {
                        start();
                      }
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
        const AppBottomNavigationBar(),
      ],
    );
  }
}
