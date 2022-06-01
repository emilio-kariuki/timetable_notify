import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todozz/model/todozz.dart';
import 'package:todozz/screens/Home.dart';
import "package:get/get.dart";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const GetMaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
