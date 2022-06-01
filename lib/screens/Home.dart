import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../building/button.dart';
import '../building/contants.dart';
import '../model/todozz.dart';
import 'add.dart';
import 'boxes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appTaskBar(),
            ValueListenableBuilder<Box<Task>>(
              valueListenable: Boxes.getTasks().listenable(),
              builder: (context, box, _) {
                final tasks = box.values.toList().cast<Task>();
                final unfinishedTasks =
                    tasks.where((task) => !task.isCompleted);

                return ListView(
                  shrinkWrap: true,
                  children: unfinishedTasks
                      .map((task) => TaskCardWidget(task: task))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _appTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subtitleStyle,
              ),
              GestureDetector(
                onTap: (() => setState(() {})),
                child: Text(
                  "Today",
                  style: titleStyle,
                ),
              )
            ],
          ),
          Button(
            label: "Add",
            function: () => Get.to(Add()),
          ),
        ],
      ),
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(task.venue),
              subtitle: Text(task.time),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () => deleteTask(task),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => taskCompleted(task),
                  child: const Text("Complete"),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }

  void taskCompleted(Task task) {
    task.isCompleted = true;

    task.save();
  }
}
