import 'package:hive_flutter/hive_flutter.dart';

part 'allboxes.g.dart';

@HiveType(typeId: 2)
class AllBoxes {

  AllBoxes({
  required this.name,
});

  @HiveField(0)
  String name;
}