import 'package:logger/logger.dart';

class MockLogger extends Logger {
  MockLogger() : super(output: _MockLogOutput());
}

/// Mock for `logger`
class _MockLogOutput extends LogOutput {
  @override
  void init() {}

  @override
  void output(OutputEvent event) {}

  @override
  void destroy() {}
}
