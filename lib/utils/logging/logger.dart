import 'package:logger/logger.dart';

class TLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: null,
    ),
    level: Level.debug,
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _logger.e(
      message,
      time: DateTime.now(),
      error: error ?? "",
      stackTrace: StackTrace.current,
    );
  }
}
