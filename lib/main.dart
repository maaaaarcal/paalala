// Copyright 2022 Marc Alburo. All rights reserved.

import 'package:flutter/material.dart';
import 'package:paalala_flutter/app/paalalaApp.dart';
import 'package:paalala_flutter/app/services/notificationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); //
  runApp(PaalalaApp());
}
