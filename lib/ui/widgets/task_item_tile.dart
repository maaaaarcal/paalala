import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paalala/ui/widgets/task_dialog.dart';
import 'package:timezone/timezone.dart';

import 'package:paalala/models/task/task.dart';
import 'package:paalala/models/task/task_model.dart';
import 'package:paalala/models/schedule.dart';

import 'package:paalala/services/notification_service.dart';

class TaskItemTile extends StatelessWidget {
  TaskItemTile(
    this.task, {
    this.onTaskChanged,
    this.onTaskDelete,
    this.onTaskEdit,
  }) : super(key: ObjectKey(task));

  final Task task;
  final Function? onTaskChanged;
  final Function? onTaskDelete;
  final Function? onTaskEdit;

  final NotificationService _notificationService = NotificationService();

  final TaskModel _taskModel = TaskModel();

  late TextEditingController _editTitleFieldController;
  late TextEditingController _editDescFieldController;

  TextStyle? getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  TZDateTime deadline = TZDateTime.now(local);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(task.key),
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {
            _taskModel.deleteTask(task.key);
          }),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                _taskModel.deleteTask(task.key);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
            SlidableAction(
              onPressed: (context) {
                _editTaskDialog(context, task);
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
          onTap: () {
            _notificationService.showNotification(task);
          },
          /*onLongPress: () async {
                  await _notificationService.showNotifications();
                },*/
          leading: CircleAvatar(
            child: Text(task.key?.toString() ?? task.title[0]),
          ),
          title: Text(task.title),
          subtitle: Text(task.description),
        ));
  }

  Future<void> _editTaskDialog(BuildContext context, Task task) {
    print(task.key);
    print(task.title);
    print(task.description);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return TaskDialog(type: DialogType.edit, value: _taskModel, taskKey: task.key);
      },
    );
  }
}
