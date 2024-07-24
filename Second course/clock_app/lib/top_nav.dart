import 'package:clock_app/events.dart';
import 'package:clock_app/main.dart';
import 'package:flutter/cupertino.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TopNavigationBarState();
  }
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: CupertinoNavigationBar(
        trailing: CupertinoButton(
            child: const Icon(
              CupertinoIcons.settings,
            ),
            onPressed: () {
              eventBus.fire(ChangeScreenEvent(4));
            }),
      ),
    );
  }
}
