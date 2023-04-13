import 'package:flutter/foundation.dart';
import 'package:paalala/services/hive_service.dart';
import 'package:paalala/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

import 'package:paalala/models/task/task.dart';
import 'package:paalala/models/schedule.dart';

import 'package:paalala/ui/widgets/task_item_tile.dart';

class TaskModel extends ChangeNotifier {
  final taskBox = HiveService().taskBox;
  final text = HiveService().taskBox.length.toString();

  static List<TaskItemTile> _taskItemList = [];

  List<TaskItemTile> get taskItemList => _taskItemList;

  Task getTask(int key) {
    return taskBox.get(key)!;
  }

  void addTask(String title, String desc, Frequency freq, TZDateTime deadline) {
    Task task = Task(
      title,
      desc,
      false,
      Schedule(frequency: freq, taskDeadline: deadline),
    );
    taskBox.add(task).then((value) {
      NotificationService().scheduleNotification(getTask(value));
    });

    print(taskBox.values);
    //notifyListeners();
  }

  List<TaskItemTile> displayTasks(box) {
    return box.values.map<TaskItemTile>((Task task) {
      return TaskItemTile(
        task,
      );
    }).toList();
  }

  void editTask(int key, String title, String desc, Frequency freq, TZDateTime deadline) {
    taskBox.put(
        key,
        Task(
          title,
          desc,
          false,
          Schedule(frequency: freq, taskDeadline: deadline),
        ));
  }

  deleteTask(int key) {
    taskBox.delete(key);
  }

  void buildTaskItemList() {
    _taskItemList = displayTasks(taskBox);
    print('build');
    notifyListeners();
  }
}
