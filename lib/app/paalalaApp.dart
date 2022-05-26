import 'package:flutter/material.dart';
import 'package:paalala_flutter/app/ui/taskPage.dart';

class PaalalaApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'paalala',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const TaskPage(), //HomePage(title: 'paalala'),
    );
  }
}