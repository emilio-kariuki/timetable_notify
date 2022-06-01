import 'package:hive/hive.dart';

part 'todozz.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String venue;

  @HiveField(1)
  late String time;

  @HiveField(2)
  late String lecture;

  @HiveField(3)
  late bool isCompleted = false;
}
