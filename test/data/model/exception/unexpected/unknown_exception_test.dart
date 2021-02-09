import 'package:linkmark_app/data/model/exception/unexpected/unknown_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnknownException Test', () {
    final unknownException = const UnknownException();

    test('message', () async {
      final expectMessage = 'This exception is not defined in the app';
      expect(unknownException.message, expectMessage);
    });

    test('toString', () async {
      final expectMessage = 'This exception is not defined in the app';
      final expectString = 'UnknownException: $expectMessage';
      expect(unknownException.toString(), expectString);
    });
  });
}
