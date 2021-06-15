import 'package:logger/logger.dart';

abstract class LoggerAdapter {
  void info(String message);
  void error(String message);
  void debug(String message);
  void warning(String message);
}

class LoggerAdapterImpl implements LoggerAdapter {
  final Logger logger;

  LoggerAdapterImpl(this.logger);
  @override
  void debug(dynamic message) {
    logger.d(message);
  }

  @override
  void info(dynamic message) {
    logger.i(message);
  }

  @override
  void error(dynamic message) {
    logger.e(message);
  }

  @override
  void warning(dynamic message) {
    logger.w(message);
  }
}
