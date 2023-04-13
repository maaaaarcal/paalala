import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import 'package:paalala/models/schedule.dart';
import 'package:paalala/models/task/task_model.dart';

import 'package:paalala/ui/widgets/buttons/date_picker_button.dart';

enum DialogType { add, edit }

class TaskDialog extends StatelessWidget {
  final DialogType type;
  final TaskModel value;
  final int? taskKey;

  TaskDialog({Key? key, required this.type, required this.value, this.taskKey}) : super(key: key);

  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TZDateTime deadline = TZDateTime.now(local);
    String title, buttonText;

    switch (type) {
      case DialogType.add:
        title = 'add a new task';
        buttonText = 'add';
        break;
      case DialogType.edit:
        title = 'edit this task';
        buttonText = 'edit';
        break;
      default:
        return AlertDialog(
          title: const Text('well, this is awkward'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("sorry, can't do that"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    }
    return AlertDialog(
      title: Text(title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: true,
            controller: _titleFieldController,
            decoration: const InputDecoration(hintText: 'task title:'),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            controller: _descFieldController,
            decoration: const InputDecoration(hintText: 'task description:'),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            'task deadline:',
            textAlign: TextAlign.left,
          ),
          Align(
            alignment: Alignment.center,
            child: DatePickerButton(callback: (datePicker) {
              deadline = datePicker;
            }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: () {
            Navigator.of(context).pop();
            print(deadline.toLocal());

            if (type == DialogType.add) {
              _addTask(
                value,
                _titleFieldController.text,
                _descFieldController.text,
                Frequency.never,
                deadline,
              );
            }

            if (type == DialogType.edit) {
              _editTask(
                value,
                taskKey!,
                _titleFieldController.text,
                _descFieldController.text,
                Frequency.never,
                deadline,
              );
            }

            _titleFieldController.clear();
            _descFieldController.clear();
          },
        ),
      ],
    );
  }

  void _addTask(TaskModel value, String title, String desc, Frequency freq, TZDateTime deadline) {
    value.addTask(title, desc, freq, deadline);
  }

  void _editTask(
      TaskModel value, int key, String title, String desc, Frequency freq, TZDateTime deadline) {
    value.editTask(key, title, desc, freq, deadline);
  }
}
