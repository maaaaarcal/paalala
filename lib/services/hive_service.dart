import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:paalala/models/task/task.dart';
import 'package:paalala/models/schedule.dart';

class HiveService {
  static final HiveService _hiveService = HiveService._internal();

  factory HiveService() {
    return _hiveService;
  }

  HiveService._internal();

  Future<Box<Task>> init({bool debug = false}) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(appDocumentDir.path);

    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ScheduleAdapter());
    Hive.registerAdapter(FrequencyAdapter());

    if (debug) {
      await Hive.deleteBoxFromDisk('taskbox');
    }

    return await Hive.openBox<Task>('taskbox');
  }

  Box<Task> get taskBox {
    return Hive.box('taskbox');
  }
}
