import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../objects/task.dart';
import 'taskItem.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final TextEditingController _newTitleFieldController = TextEditingController();
  final TextEditingController _newDescFieldController = TextEditingController();

  late TextEditingController _editTitleFieldController;
  late TextEditingController _editDescFieldController;

  final List<Task> tasks = <Task>[];
  final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
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
            TaskItem(
              task: Task(title: 'heyo', description: 'tap or swipe me', checked: false),
              onTaskChanged: _handleTaskChange,
              onTaskDelete: _errorDialog,
              onTaskEdit: _errorDialog,
            ),
            ...box.values.toList().map((Task task) {
              return TaskItem(
               task: task,
                onTaskChanged: _handleTaskChange,
                onTaskDelete: _deleteTask,
                onTaskEdit: _editTaskDialog,
              );
             }).toList(),
            const Divider(),
            const SizedBox(height: 5),
            TextButton(
              style: style,
              onPressed: () => _newTaskDialog(),
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
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => _displayDialog(),
      //     tooltip: 'add task',
      //     child: const Icon(Icons.add)),
      //  )
    );
  }

  void _displayTasks() {
    tasks.map((Task task) {
      return TaskItem(
        task: task,
        onTaskChanged: _handleTaskChange,
        onTaskDelete: _deleteTask,
        onTaskEdit: _editTaskDialog,
      );
    }).toList();
  }

  void _handleTaskChange(Task task) {
    setState(() {
      task.checked = !task.checked;
    });
  }

  void _addTask(String title, String desc) {
    setState(() {
      box.add(Task(title: title, description: desc, checked: false));
    });
    _newTitleFieldController.clear();
    _newDescFieldController.clear();
  }

  void _deleteTask(int key) {
    setState(() {
      box.delete(key);
    });
  }

  void _editTask(int key, String title, String desc) {
    print(key);
    print(title);
    print(desc);
    setState(() {
      box.put(key, Task(title: title, description: desc, checked: false));
    });
    _editTitleFieldController.clear();
    _editDescFieldController.clear();
  }

  Future<void> _newTaskDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
           title: const Text('add a new task'),
          content: Column(
            children: [
              TextField(
                controller: _newTitleFieldController,
                decoration: const InputDecoration(hintText: 'task title'),
              ), TextField(
                controller: _newDescFieldController,
                decoration: const InputDecoration(hintText: 'task description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTask(_newTitleFieldController.text, _newDescFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editTaskDialog(Task task) async {
    print(task.key);
    print(task.title);
    print(task.description);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('edit this task'),
          content: Column(
            children: [
              TextField(
                controller: _editTitleFieldController = TextEditingController(text: task.title),
              ), TextField(
                controller: _editDescFieldController = TextEditingController(text: task.description),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _editTask(
                  task.key,
                  _editTitleFieldController.text,
                  _editDescFieldController.text,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _errorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
      },
    );
  }
}