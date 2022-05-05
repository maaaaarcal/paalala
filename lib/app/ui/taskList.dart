import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paalala_flutter/app/objects/task.dart';
import 'package:paalala_flutter/app/objects/taskItem.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descFieldController = TextEditingController();

  final List<Task> tasks = <Task>[];

  @override
  void initState() {
    tasks.add(Task(title: 'heyo', description: 'tap me', checked: false));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('paalala'),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: [
            ...tasks.map((Task task) {
              return TaskItem(
               task: task,
                onTaskChanged: _handleTaskChange,
              );
             }).toList(),
            const Divider(),
            const SizedBox(height: 5),
            TextButton(
              style: style,
              onPressed: () => _displayDialog(),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('add task'),
                ]
              )
            ),
          ],
      )
      /*

      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'add task',
          child: const Icon(Icons.add)),
       )
       */
    );
  }

  void _displayTasks() {
    tasks.map((Task task) {
      return TaskItem(
        task: task,
        onTaskChanged: _handleTaskChange
      );
    }).toList();
  }

  void _handleTaskChange(Task task) {
    setState(() {
      task.checked = !task.checked;
    });
  }

  void addTaskItem(String title, String desc) {
    setState(() {
      tasks.add(Task(title: title, description: desc, checked: false));
    });
    _titleFieldController.clear();
    _descFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('add a new task'),
          content: Column(
            children: [
              TextField(
                controller: _titleFieldController,
                decoration: const InputDecoration(hintText: 'task title'),
              ), TextField(
                controller: _descFieldController,
                decoration: const InputDecoration(hintText: 'task description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('add'),
              onPressed: () {
                Navigator.of(context).pop();
                addTaskItem(_titleFieldController.text, _descFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }
}