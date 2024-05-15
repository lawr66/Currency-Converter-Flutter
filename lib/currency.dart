import 'package:hive_flutter/hive_flutter.dart';

part 'currency.g.dart';

@HiveType(typeId: 1)
class Currency {

  Currency ({
    required this.abbreviation,
    required this.name,
    required this.buyValue,
    required this.sellValue
});

  @HiveField(0)
  String abbreviation;

  @HiveField(1)
  String name;

  @HiveField(2)
  double buyValue;

  @HiveField(3)
  double sellValue;
}
