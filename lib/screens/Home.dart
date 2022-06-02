import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todozz/screens/completedTasks.dart';

import '../building/button.dart';
import '../building/contants.dart';
import '../building/input_field.dart';
import '../model/todozz.dart';
import 'add.dart';
import 'boxes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final lecture = TextEditingController();
  final time = TextEditingController();
  final venue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _appTaskBar(),
              Row(children: [
                Expanded(
                  // ignore: unnecessary_new
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 30.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 20,
                      )),
                ),
                const Text("Tasks"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 20,
                      )),
                ),
              ]),
              ValueListenableBuilder<Box<Task>>(
                valueListenable: Boxes.getTasks().listenable(),
                builder: (context, box, _) {
                  final tasks = box.values.toList().cast<Task>();
                  final unfinishedTasks =
                      tasks.where((task) => !task.isCompleted);

                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Get.to(const CompletedTaskPage()),
        tooltip: "Completed tasks",
        child: const Icon(
          Icons.check,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  _appTaskBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9, top: 9),
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
            function: () => _showBottomSheet(context),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(
    BuildContext context,
  ) {
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: Colors.white,
      Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                  title: "Lecture",
                  hint: "Enter the lecture",
                  controller: lecture),
              InputField(
                  title: "Venue", hint: "Enter the venue", controller: venue),
              InputField(
                  title: "Time",
                  hint: "Choose Time",
                  controller: time,
                  widget: Icon(Icons.av_timer, color: Colors.grey)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    label: "Add",
                    function: () {
                      addTask(venue.text, time.text, lecture.text);
                      venue.clear();
                      time.clear();
                      lecture.clear();

                      Navigator.pop(context);
                    },
                  ),
                  Button(
                    label: "Close",
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask(String venue, String time, String lecture) {
    final task = Task()
      ..venue = venue == "" ? "(Untitled)" : venue
      ..time = time == "" ? "(No description)" : time
      ..lecture = lecture == "" ? "(No description)" : lecture
      ..isCompleted = false;

    final box = Boxes.getTasks();
    box.add(task);
  }
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "TASKS",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.black.withOpacity(0.7),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(task.lecture,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ))),
                  const SizedBox(height: 10),
                  Text(task.venue,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 231, 231, 231),
                      ))),
                  const SizedBox(height: 7),
                  Text(task.time,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 190, 188, 188),
                      ))),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () => deleteTask(task),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              primary: cardColor),
                          child: const Text("Delete"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () => taskCompleted(task),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              primary: cardColor),
                          child: const Text("Complete"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted == false ? "TODO" : "COMPLETED",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
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
