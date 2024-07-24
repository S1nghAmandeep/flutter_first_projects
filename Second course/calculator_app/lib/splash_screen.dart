// import 'package:calculator_app/calculator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _SplashScreenState();
//   }
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (_) => const Calculator(title: 'Calculator App'),
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/playstore.png',
//               height: 200,
//             ),
//             // Text(
//             //   'Calulator App',
//             //   style: TextStyle(
//             //     fontSize: 35,
//             //     color: Colors.green,
//             //     fontWeight: FontWeight.bold,
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
