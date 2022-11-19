import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// ignore: non_constant_identifier_names
final Log = Logger(
  filter: CustomFilter(),
  printer: CustomPrinter(),
  output: CustomOutput(),
);

class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kDebugMode) {
      return true; // in debug mode, log everything
    } else {
      return event.level.index >= Level.info.index; // in release mode, only log >= info
    }
  }
}

class CustomPrinter extends SimplePrinter {
  CustomPrinter() : super(colors: false);

  @override
  List<String> log(LogEvent event) {
    var lines = super.log(event);
    if (event.stackTrace != null) {
      lines.addAll(event.stackTrace.toString().split('\n'));
    }
    return lines;
  }
}

/// Overrides the default [LogOutput] used by [Log].
LogOutput? debugLogOutputOverride;

class CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    bool skipOutput = false;
    assert(() {
      if (debugLogOutputOverride != null) {
        debugLogOutputOverride!.output(event);
        skipOutput = true;
      }
      return true;
    }());
    if (!skipOutput && kDebugMode) {
      // in debug mode, log to console
      for (var line in event.lines) {
        // ignore: avoid_print
        print(line);
      }
    }
  }
}
