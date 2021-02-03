import 'dart:io';

import 'package:linkmark_app/data/model/exception/unexpected/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NetworkException Test', () async {
    expect(
        NetworkException(
          dioError: DioError(type: DioErrorType.CONNECT_TIMEOUT),
        ).type,
        equals(NetworkExceptionType.timeout));

    expect(
        NetworkException(
          dioError: DioError(type: DioErrorType.RECEIVE_TIMEOUT),
        ).type,
        equals(NetworkExceptionType.timeout));

    expect(
        NetworkException(
          dioError: DioError(type: DioErrorType.SEND_TIMEOUT),
        ).type,
        equals(NetworkExceptionType.network));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 400)),
        ).type,
        equals(NetworkExceptionType.badRequest));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 401)),
        ).type,
        equals(NetworkExceptionType.unauthorized));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 500)),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 502)),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 503)),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
              type: DioErrorType.RESPONSE, response: Response(statusCode: 504)),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(type: DioErrorType.CANCEL),
        ).type,
        equals(NetworkExceptionType.cancel));

    expect(
        NetworkException(
          dioError: DioError(
              error: const SocketException('Failed host lookup: wasabeef.jp'),
              type: DioErrorType.DEFAULT),
        ).type,
        equals(NetworkExceptionType.network));

    expect(
        NetworkException(
          dioError: DioError(type: DioErrorType.DEFAULT),
        ).type,
        equals(NetworkExceptionType.unknown));
  });
}
