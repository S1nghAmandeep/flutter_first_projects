import 'package:flutter/material.dart';
import 'dart:async';

///
/// Define an interface that will define the state of any given Traffic Light
/// by bascially assigning a
///
abstract class TrafficLightState {
  void next(TrafficLight light);
  Color getColor();
}

///
/// Define three concrete states for the three colors of a traffic light.
///
///

///
/// Our Green Traffic Light
/// Note: that this state knows that the next state is Yellow Traffic Light
///
class GreenState implements TrafficLightState {
  @override
  void next(TrafficLight light) {
    light.currentState = YellowState();
  }

  @override
  Color getColor() {
    return Colors.green;
  }
}

///
/// Our Yellow/Orange Traffic Light
/// Note: that this state knows that the next state is Red Traffic Light
///
class YellowState implements TrafficLightState {
  @override
  void next(TrafficLight light) {
    light.currentState = RedState();
  }

  @override
  Color getColor() {
    return Colors.yellow;
  }
}

///
/// Our Red Traffic Light
/// Note: that this state knows that the next state is Green Traffic Light
///
class RedState implements TrafficLightState {
  @override
  void next(TrafficLight light) {
    light.currentState = BlueState();
  }

  @override
  Color getColor() {
    return Colors.red;
  }
}

class BlueState implements TrafficLightState {
  @override
  void next(TrafficLight light) {
    light.currentState = GreenState();
  }

  @override
  Color getColor() {
    return Colors.blueAccent;
  }
}

///
/// Define the context, which holds the current state.
/// Note that we have hardcoded the initial state to be Green Light
/// and then the changes will go through the traffic light cycle.
///
/// Note that we do not have currently a way to reset the TrafficLight state
/// but this could be easily remedied by adding a setter for any state.
///
class TrafficLight {
  TrafficLightState currentState = GreenState();

  void next() {
    currentState.next(this);
  }

  Color getColor() {
    return currentState.getColor();
  }
}

///
/// Main entry point for the Flutter application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

///
/// Our visualization of the State Design pattern modelling Traffic Lights
/// Note: we are using a timer to move between each state at 6 second intervals
///
class MyAppState extends State<MyApp> {
  // intialize our state context - it will start with a green light
  final light = TrafficLight();
  int cycle = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  ///
  /// Create the timer with an interval of 3 seconds. at each <tick> of the
  /// timer we transition the TrafficLight to the next state
  ///
  void startTimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        cycle++;
        light.next();
      });
    });
  }

  @override

  ///
  /// This is our visualization of the traffic light cycle. A very simple
  /// colored box render of the 'current' state of the traffic light context
  /// as well as the current number of transitions (i.e. cycles)
  ///
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Traffic Light Simulation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: light.getColor(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Cycle: $cycle',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
