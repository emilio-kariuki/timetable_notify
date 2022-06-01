import 'package:hive/hive.dart';

import '../model/todozz.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box<Task>('tasks');
}
