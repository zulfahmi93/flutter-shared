import 'package:hive/hive.dart';

part 'models.g.dart';

Future<Box<AppLog>> openLogDb(String dbName) {
  return Hive.openBox<AppLog>(dbName);
}

@HiveType(typeId: 0)
class AppLog extends HiveObject {
  // ---------------------------- CONSTRUCTORS ----------------------------
  AppLog({
    required this.timestamp,
    required this.level,
    required this.levelString,
    required this.message,
    this.error,
    this.stackTrace,
  });

  // ------------------------------- FIELDS -------------------------------
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final int level;

  @HiveField(2)
  final String levelString;

  @HiveField(3)
  final String message;

  @HiveField(4)
  final String? error;

  @HiveField(5)
  final String? stackTrace;
}
