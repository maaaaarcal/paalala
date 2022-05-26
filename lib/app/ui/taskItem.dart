import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

import '../services/notificationService.dart';
import '../objects/task.dart';
import 'taskPage.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    required this.task,
    required this.onTaskChanged,
    required this.onTaskDelete,
    required this.onTaskEdit,
  }) : super(key: ObjectKey(task));

  final Task task;
  final onTaskChanged;
  final onTaskDelete;
  final onTaskEdit;

  final box = Hive.box<Task>('taskBox');

  late TextEditingController _titleFieldController;
  late TextEditingController _descFieldController;

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
    return Slidable(
      key: ValueKey(0),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {onTaskDelete(task.key);}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              onTaskDelete(task.key);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete',
          ),
          SlidableAction(
            onPressed: (context) {
              onTaskEdit(task);
            },
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'edit',
          ),
        ],
      ),
      child: ListTile(
        /*onTap: () {
        //onTaskChanged(task);

      },*/
        onTap: () async {
          await _notificationService.showNotifications(task.key, task);
        },
        /*onLongPress: () async {
                  await _notificationService.showNotifications();
                },*/
        leading: CircleAvatar(
          child: Text(task.key?.toString() ?? task.title[0]),
        ),
        title: Text(task.title),
        subtitle: Text(task.description),
      )
    );
  }
}