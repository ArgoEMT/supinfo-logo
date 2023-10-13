import 'package:logger/logger.dart';

class LogsFilter extends LogFilter {

  @override
  bool shouldLog(LogEvent event) {
    //todo: add firebase logging
    return true;
  }
}
