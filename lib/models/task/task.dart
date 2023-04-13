import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart';

import 'package:paalala/models/schedule.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool checked;

  @HiveField(3)
  Schedule? schedule;

  Task(this.title, this.description, this.checked, this.schedule);

  TZDateTime get taskDeadline {
    return schedule!.taskDeadline!;
  }

  Frequency get notificationFrequency {
    return schedule!.frequency;
  }
}
