import 'package:flutter/material.dart';
import 'package:paalala_flutter/app/services/notificationService.dart';
import 'package:paalala_flutter/app/objects/task.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    required this.task,
    required this.onTaskChanged,
  }) : super(key: ObjectKey(task));

  final Task task;
  final onTaskChanged;

  final NotificationService _notificationService = NotificationService();

  TextStyle? _getTextStyle(bool checked) {

    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /*onTap: () {
        //onTaskChanged(task);

      },*/
      onTap: () async {
        await _notificationService.showNotifications(task);
      },
      /*onLongPress: () async {
                  await _notificationService.showNotifications();
                },*/
      leading: CircleAvatar(
        child: Text(task.title[0]),
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
    );
  }
}