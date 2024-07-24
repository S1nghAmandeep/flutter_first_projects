import 'package:clock_app/bottom_nav.dart';
import 'package:clock_app/constants.dart';
import 'package:clock_app/events.dart';
import 'package:clock_app/main.dart';
import 'package:clock_app/top_nav.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
     isDarkMode = isGlobalDarkMode;
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
                Row(
                  children: [
                    const Text(
                      "   Dark Mode",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      value: isDarkMode,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                          isGlobalDarkMode = value;
                          eventBus.fire(DarkModeEvent(isDarkMode));
                        });
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '   Alarm Volume',
                      style:
                          TextStyle(color: CupertinoColors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    CupertinoSlider(
                      value: volume,
                      activeColor: CupertinoColors.activeBlue,
                      onChanged: (value) {
                        setState(() {
                          volume = value;
                        });
                      },
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
        const AppBottomNavigationBar()
      ],
    );
  }
}
