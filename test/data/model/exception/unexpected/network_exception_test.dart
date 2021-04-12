import 'dart:io';
import 'dart:isolate';

import 'package:linkmark_app/data/model/exception/unexpected/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final requestOptions = RequestOptions(path: "");

  test('NetworkException type Test', () async {
    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.connectTimeout,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.timeout));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.receiveTimeout,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.timeout));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.sendTimeout,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.network));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 400,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.badRequest));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 401,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.unauthorized));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 500,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 502,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 503,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.response,
            response: Response(
              statusCode: 504,
              requestOptions: requestOptions,
            ),
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.server));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.cancel,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.cancel));

    expect(
        NetworkException(
          dioError: DioError(
            error: const SocketException('Failed host lookup: linkmark.dev'),
            type: DioErrorType.other,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.network));

    expect(
        NetworkException(
          dioError: DioError(
            type: DioErrorType.other,
            requestOptions: requestOptions,
          ),
        ).type,
        equals(NetworkExceptionType.unknown));
  });

  test('NetworkException message Test', () async {
    final errorMessage = 'Failed host lookup: linkmark.dev';
    final exception = SocketException(errorMessage);

    final dioError = DioError(
      error: exception,
      type: DioErrorType.other,
      requestOptions: requestOptions,
    );

    final expectMessage = '${exception.runtimeType.toString()}: $errorMessage';

    expect(
        NetworkException(
          dioError: dioError,
        ).message,
        expectMessage);
  });

  group('NetworkException toString Test', () {
    test('DioErrorType.CONNECT_TIMEOUT', () async {
      final expectMessage = 'NetworkException [NetworkExceptionType.timeout]: ';

      expect(
          NetworkException(
            dioError: DioError(
              type: DioErrorType.connectTimeout,
              requestOptions: requestOptions,
            ),
          ).toString(),
          expectMessage);
    });

    test('RemoteError', () async {
      final error = RemoteError('description', 'stackDescription');
      final expectMessage =
          '''NetworkException [NetworkExceptionType.unknown]: ${error.toString()}\n${error.stackTrace}''';
      expect(
          NetworkException(
            dioError: DioError(
              error: error,
              requestOptions: requestOptions,
            ),
          ).toString(),
          expectMessage);
    });

    test('SocketException', () async {
      final errorMessage = 'Failed host lookup: linkmark.dev';
      final exception = SocketException(errorMessage);

      final dioError = DioError(
        error: exception,
        type: DioErrorType.other,
        requestOptions: requestOptions,
      );

      final expectMessage =
          '''NetworkException [NetworkExceptionType.network]: ${exception.runtimeType.toString()}: $errorMessage''';

      expect(
          NetworkException(
            dioError: dioError,
          ).toString(),
          expectMessage);
    });
  });
}
