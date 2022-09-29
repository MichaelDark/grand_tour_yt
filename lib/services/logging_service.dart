import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

export 'package:logger/logger.dart' show Level;

@lazySingleton
class LoggingService extends Logger {
  LoggingService()
      : super(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            printTime: false,
          ),
        );
}
