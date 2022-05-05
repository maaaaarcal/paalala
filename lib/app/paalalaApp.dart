import 'package:flutter/material.dart';
import 'package:paalala_flutter/app/ui/taskList.dart';

class PaalalaApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'paalala',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const TaskList(), //HomePage(title: 'paalala'),
    );
  }
}