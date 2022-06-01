// ignore_for_file: prefer_const_constructors
import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../building/back.dart';
import '../building/button.dart';
import '../building/input_field.dart';
import '../model/todozz.dart';
import 'boxes.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final lecture = TextEditingController();

  final venue = TextEditingController();

  final time = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Back(
                        imageUrl: "assets/back.png",
                        function: Navigator.of(context).pop,
                      ),
                    ],
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                    label: "Add",
                    function: () {
                      addTask(venue.text, time.text, lecture.text);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
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
