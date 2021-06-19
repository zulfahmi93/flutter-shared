import 'package:hive/hive.dart';
import 'package:logging/logging.dart';

import 'models.dart';

// ------------------------------ FUNCTIONS -----------------------------
Future<LogService> initialiseLogService({
  required Level level,
  required bool logToStdOut,
  required bool logToDatabase,
  String? logDatabaseName,
}) async {
  assert(!logToDatabase ||
      (logToDatabase && logDatabaseName?.trim().isNotEmpty == true));

  final service = await LogService.create(
    logToStdOut: logToStdOut,
    logToDatabase: logToDatabase,
    logDatabaseName: logDatabaseName,
  );
  Logger.root.level = level;
  Logger.root.onRecord.listen(service.log);
  return service;
}

// ------------------------------- CLASSES ------------------------------
class LogService {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const LogService._({
    required this.logToStdOut,
    required this.logToDatabase,
    this.database,
  });

  // ------------------------------- FIELDS -------------------------------
  final bool logToStdOut;
  final bool logToDatabase;
  final Box<AppLog>? database;

  // ------------------------------- METHODS ------------------------------
  Future<void> log(LogRecord log) async {
    if (logToStdOut) {
      print('${log.level.name}: ${log.time}: ${log.message}');
    }
    if (logToDatabase && database != null) {
      await database!.add(
        AppLog(
          timestamp: log.time,
          level: log.level.value,
          levelString: log.level.name,
          message: log.message,
          error: log.error?.toString(),
          stackTrace: log.stackTrace?.toString(),
        ),
      );
    }
  }

  Future<void> clearLogDatabase() async {
    if (database != null) {
      await database!.clear();
    }
  }

  // --------------------------- STATIC METHODS ---------------------------
  static Future<LogService> create({
    required bool logToStdOut,
    required bool logToDatabase,
    String? logDatabaseName,
  }) async {
    assert(!logToDatabase ||
        (logToDatabase && logDatabaseName?.trim().isNotEmpty == true));

    return LogService._(
      logToStdOut: logToStdOut,
      logToDatabase: logToDatabase,
      database: logToDatabase ? await openLogDb(logDatabaseName!) : null,
    );
  }
}
