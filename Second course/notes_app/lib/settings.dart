import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/events.dart';
import 'package:notes_app/main.dart';
// import 'package:notes_app/note.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;
  bool areNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    var brightness =
        WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged;
    isDarkMode = (brightness == Brightness.dark);
  }

  void requestNotificationPermissionAndroid() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showConfirmDeleteAllNotesDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure you want to delete All notes?'),
            actions: [
              TextButton(
                onPressed: () {
                  eventBus.fire(DeleteAllNotesEvent());
                  Navigator.of(context).pop();
                },
                child: const Text(
                  DELETE,
                  style: TextStyle(color: RED),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(CANCEL),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: YELLOW,
        foregroundColor: BLACK,
        title: const Text(NOTES),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              SETTINGS,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                DARK_MODE,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 35),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                  eventBus.fire(DarkModeEvent(isDarkMode));
                },
                
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              const Text(
                NOTIFICATIONS,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 35),
              Switch(
                value: areNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    areNotificationsEnabled = !areNotificationsEnabled;
                  });
                  if (areNotificationsEnabled) {
                    try {
                      if (Platform.isAndroid) {
                        requestNotificationPermissionAndroid();
                      } else if (Platform.isIOS) {
                        print('isIos');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                DELETE_ALL_NOTES,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 35),
              OutlinedButton(
                onPressed: () {
                  showConfirmDeleteAllNotesDialog();
                },
                child: const Text(
                  DELETE,
                  style: TextStyle(color: RED),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
