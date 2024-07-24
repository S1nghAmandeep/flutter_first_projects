import 'dart:async';

import 'package:clock_app/bottom_nav.dart';
import 'package:clock_app/top_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ClockScreenState();
  }
}

class _ClockScreenState extends State<ClockScreen> {
  late DateTime currentDate;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => update());
  }

  void update() {
    setState(() {
      currentDate = DateTime.now();
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
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: DateFormat('h:mm').format(currentDate),
                    style: const TextStyle(fontSize: 100),
                  ),
                  TextSpan(
                    text: " " + DateFormat('a').format(currentDate),
                    style: const TextStyle(fontSize: 60),
                  ),
                  TextSpan(
                    text: "\n" + DateFormat('EEEE, MMMM dd').format(currentDate),
                    style: const TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const AppBottomNavigationBar(),
      ],
    );
  }
}
