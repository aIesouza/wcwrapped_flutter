import 'package:flutter/material.dart';

import 'screens/wrapped_story_screen.dart';

void main() {
  runApp(const WrappedApp());
}

class WrappedApp extends StatelessWidget {
  const WrappedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Round Recap',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF111111),
        fontFamily: 'InterBold',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3385E3),
          brightness: Brightness.dark,
        ),
      ),
      home: const WrappedStoryScreen(),
    );
  }
}
