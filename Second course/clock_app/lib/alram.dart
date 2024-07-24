import 'package:flutter/cupertino.dart';
import 'package:clock_app/top_nav.dart';
import 'package:clock_app/bottom_nav.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:io';
import 'dart:async';
import 'package:clock_app/constants.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key, required this.title});

  final String title;

  @override
  State<AlarmScreen> createState() {
    return _AlarmScreenState();
  }
}

class _AlarmScreenState extends State<AlarmScreen> {
  late Timer timer;

  void playAlarm() {
    if (Platform.isAndroid || Platform.isIOS) {
      FlutterRingtonePlayer().playAlarm(volume: volume);
      // FlutterRingtonePlayer.playAlarm(volume: volume, asAlarm: true, looping: true);
    }
  }

  void showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
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
                CupertinoButton.filled(
                  child: const Text('15 seconds'),
                  onPressed: () {
                    timer =
                        Timer(const Duration(seconds: 15), () => playAlarm());
                  },
                ),
                const Spacer(),
                CupertinoButton.filled(
                  child: const Text('30 seconds'),
                  onPressed: () {
                    timer =
                        Timer(const Duration(seconds: 30), () => playAlarm());
                  },
                ),
                const Spacer(),
                CupertinoButton.filled(
                  child: const Text('45 seconds'),
                  onPressed: () {
                    timer =
                        Timer(const Duration(seconds: 45), () => playAlarm());
                  },
                ),
                const Spacer(),
                CupertinoButton.filled(
                  child: const Text('1 minute'),
                  onPressed: () {
                    timer =
                        Timer(const Duration(seconds: 60), () => playAlarm());
                  },
                ),
                const Spacer(),
                CupertinoButton.filled(
                  child: const Text('Custom'),
                  onPressed: () => showDialog(CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    onTimerDurationChanged: (Duration newDuration) {
                      setState(() {
                        timer = Timer(newDuration, () => playAlarm());
                      });
                    },
                  )),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        const AppBottomNavigationBar(),
      ],
    );
  }
}
