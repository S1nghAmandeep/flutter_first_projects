// import 'package:clock_app/bottom_nav.dart';
import 'package:clock_app/alram.dart';
import 'package:clock_app/clock.dart';
import 'package:clock_app/constants.dart';
import 'package:clock_app/events.dart';
import 'package:clock_app/settings.dart';
import 'package:clock_app/stopwatch.dart';
import 'package:clock_app/timer.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

CupertinoTabController tabController = CupertinoTabController();
final List<StatefulWidget> screens = [
  const ClockScreen(title: CLOCK),
  const AlarmScreen(title: ALARM),
  const TimerScreen(title: TIMER),
  const StopwatchScreen(title: STOPWATCH),
  const SettingsScreen(title: SETTINGS),
];

EventBus eventBus = EventBus();
StatefulWidget activeScreen = screens[0];
bool isGlobalDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Brightness _brightness = isGlobalDarkMode ? Brightness.dark : Brightness.light;

  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      eventBus.fire(ChangeScreenEvent(tabController.index));
    });
    eventBus.on<ChangeScreenEvent>().listen((event) {
      setState(() {
        if (event.screenIndex < 4) {
          tabController.index = event.screenIndex;
        }
        changeScreen(event.screenIndex);
      });
    });
    eventBus.on<DarkModeEvent>().listen((event) {
      if (event.isDarkMode) {
        changeTheme(Brightness.dark);
      } else {
        changeTheme(Brightness.light);
      }
    });
  }

  void changeTheme(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  void changeScreen(int screenIndex) {
    activeScreen = screens[screenIndex];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Clock App',
      theme: CupertinoThemeData(brightness: _brightness),
      home: activeScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//          const BottomNavigationBar(),
//       ],
//     );
//   }
// }
