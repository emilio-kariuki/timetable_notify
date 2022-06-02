import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../building/contants.dart';
import '../model/todozz.dart';
import 'boxes.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({Key? key}) : super(key: key);

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text('Completed'),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          final finishedTasks = tasks.where((task) => task.isCompleted);

          return ListView(
            children: finishedTasks
                .map((task) => CompletedTaskWidget(task: task))
                .toList(),
          );
        },
      ),
    );
  }
}

class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted == false ? "TASKS" : "COMPLETED",
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
                  const SizedBox(height: 10),
                  Text(task.time,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 190, 188, 188),
                      ))),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () => deleteTask(task),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: cardColor),
                          child: const Text("Remove"),
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
}
