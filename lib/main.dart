// Copyright 2022 Marc Alburo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:paalala/paalala_app.dart';
import 'package:paalala/models/task/task.dart';
import 'package:paalala/services/notification_service.dart';
import 'package:paalala/services/hive_service.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  final Box<Task> taskBox = await HiveService().init(debug: true);

  runApp(PaalalaApp());
}
