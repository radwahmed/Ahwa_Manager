import 'package:flutter/material.dart';
import 'screens/ahwa_home_page.dart';

void main() {
  runApp(const SmartAhwaManagerApp());
}

class SmartAhwaManagerApp extends StatelessWidget {
  const SmartAhwaManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahwa Manager',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AhwaHomePage(),
    );
  }
}
