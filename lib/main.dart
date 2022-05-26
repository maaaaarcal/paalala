// Copyright 2022 Marc Alburo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/paalalaApp.dart';
import 'app/services/notificationService.dart';

import 'app/objects/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(PaalalaApp());
}
