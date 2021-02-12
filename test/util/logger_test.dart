import 'package:flutter_test/flutter_test.dart';
import 'package:linkmark_app/util/logger.dart';
import 'package:simple_logger/simple_logger.dart';

void main() {
  test('logger Test', () {
    expect(logger.level, Level.INFO);
    expect(logger.includeCallerInfo, isTrue);
  });
}
