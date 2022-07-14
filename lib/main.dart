import 'package:flutter/material.dart';
import 'package:room_app/splash.dart';

import 'inside_app/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => const HomeScreen(),
        'splash': (context) => const Splash(),
      },
      initialRoute: 'splash',
    );
  }
}
