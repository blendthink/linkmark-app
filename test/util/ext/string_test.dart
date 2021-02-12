import 'package:linkmark_app/util/ext/string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('StringExt Test', () async {
    final string = "\u000A\u000D\u0085\u2028\u2029";

    expect(string.trimNewline(), isEmpty);
  });
}
