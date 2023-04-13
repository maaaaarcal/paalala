import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';

part 'schedule.g.dart';

@HiveType(typeId: 2)
enum Frequency {
  @HiveField(0)
  never,

  @HiveField(1)
  hourly,

  @HiveField(2)
  daily,

  @HiveField(3)
  weekly,

  @HiveField(4)
  monthly,

  @HiveField(5)
  yearly,
}

@HiveType(typeId: 1)
class Schedule extends HiveObject {

  @HiveField(0)
  Frequency frequency;

  @HiveField(1)
  TZDateTime? taskDeadline;

  static const freq = Frequency.values;

  Schedule({required this.frequency, this.taskDeadline});
}