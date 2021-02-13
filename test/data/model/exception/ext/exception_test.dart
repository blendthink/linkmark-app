import 'package:dio/dio.dart';
import 'package:linkmark_app/data/model/exception/ext/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkmark_app/data/model/exception/unexpected/network_exception.dart';
import 'package:linkmark_app/data/model/exception/unexpected/unknown_exception.dart';

void main() {
  group('ExceptionExt Test', () {
    test('AppException is same', () {
      const exception = UnknownException();
      final appException = exception.toAppException();
      expect(appException, exception);
    });

    test('DioError is NetworkException', () {
      expect(DioError().toAppException(), isInstanceOf<NetworkException>());
    });

    test('Exception is UnknownException', () {
      expect(Exception().toAppException(), isInstanceOf<UnknownException>());
    });
  });
}
