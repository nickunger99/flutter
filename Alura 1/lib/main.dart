import 'package:Tasks/data/task_inherited.dart';
import 'package:flutter/material.dart';

import 'screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TaskInherited(
        child: const InitialScreen(),
      ),
    );
  }
}
