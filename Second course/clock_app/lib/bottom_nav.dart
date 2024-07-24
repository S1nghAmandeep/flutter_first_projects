import 'package:clock_app/constants.dart';
import 'package:clock_app/main.dart';
import 'package:flutter/cupertino.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() {
    return _AppBottomNavigationBar();
  }
}

class _AppBottomNavigationBar extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: CupertinoTabScaffold(
        controller: tabController,
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (context) {
              return Container();
            },
          );
        },
        tabBar: CupertinoTabBar(height: 60, items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            activeIcon: Icon(CupertinoIcons.clock_fill),
            label: CLOCK,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.alarm),
            activeIcon: Icon(CupertinoIcons.alarm_fill),
            label: ALARM,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.timer),
            activeIcon: Icon(CupertinoIcons.timer_fill),
            label: TIMER,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.stopwatch),
            activeIcon: Icon(CupertinoIcons.stopwatch_fill),
            label: STOPWATCH,
          ),
        ]),
      ),
    );
  }
}
