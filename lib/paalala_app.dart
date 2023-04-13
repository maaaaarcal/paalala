import 'package:flutter/material.dart';

import 'package:paalala/ui/screens/task_screen.dart';

class PaalalaApp extends StatelessWidget {
  const PaalalaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'paalala',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const TaskScreen(), //HomePage(title: 'paalala'),
    );
  }
}
