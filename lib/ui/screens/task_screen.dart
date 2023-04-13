import 'package:flutter/material.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:paalala/services/hive_service.dart';
import 'package:paalala/ui/widgets/task_dialog.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

import 'package:paalala/models/task/task.dart';
import 'package:paalala/models/task/task_model.dart';
import 'package:paalala/models/schedule.dart';

import 'package:paalala/ui/widgets/task_item_tile.dart';
import 'package:paalala/ui/widgets/buttons/date_picker_button.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  final HiveService _hiveService = HiveService();

  final TaskModel _taskModel = TaskModel();

  //late final Box<Task> box;
  final List<Task> tasks = <Task>[];
  TZDateTime deadline = TZDateTime.now(local);

  //TZDateTime selectedDate = TZDateTime.now(local);

  @override
  void initState() {
    super.initState();
    //box = Hive.box('taskbox');

    _hiveService.taskBox.watch().listen((event) {
      _taskModel.buildTaskItemList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    );

    return ChangeNotifierProvider.value(
      value: _taskModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('paalala'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: [
            TaskItemTile(
              Task('heyo', 'tap or swipe me', false,
                  Schedule(frequency: Frequency.never, taskDeadline: deadline)),
              onTaskChanged: _handleTaskChange,
              onTaskDelete: _errorDialog,
              onTaskEdit: _errorDialog,
            ),
            // ..._taskModel.displayTasks(
            //     _handleTaskChange, _editTaskDialog),

            Consumer<TaskModel>(
              builder: (context, value, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.taskItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('aaa ${value.taskItemList[index].task.title}');
                      return value.taskItemList[index];
                    });
              },
            ),

            const Divider(),
            const SizedBox(height: 5),
            Consumer<TaskModel>(builder: (context, value, child) {
              return TextButton(
                  style: style,
                  onPressed: () => _newTaskDialog(value),
                  child: Row(children: const [
                    Icon(Icons.add),
                    SizedBox(width: 5),
                    Text('add task'),
                  ]));
            })
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () => _displayDialog(),
        //     tooltip: 'add task',
        //     child: const Icon(Icons.add)),
        //  )
      ),
    );
  }

  _handleTaskChange(Task task) {
    setState(() {
      task.checked = !task.checked;
    });
  }

  Future<void> _newTaskDialog(TaskModel value) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return TaskDialog(value: value, type: DialogType.add);
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
