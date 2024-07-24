import 'package:first_app/gradient_container.dart';
import 'package:flutter/material.dart';


const color1 = Color.fromARGB(255, 44, 171, 250);
const color2 = Color.fromARGB(255, 18, 113, 255);

void main() {
  runApp(
     const MaterialApp(
      home: Scaffold(
        body: GradientContainer(colors : [color1, color2]),
      ),
    ),
  );
}

