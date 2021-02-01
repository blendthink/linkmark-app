import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../unexpected_exception.dart';

class NetworkException implements UnexpectedException {
  final DioError _dioError;

  NetworkException({
    @required DioError dioError,
  }) : _dioError = dioError;

  _ErrorType get errorType {
    _ErrorType type;
    switch (_dioError.type) {
      case DioErrorType.DEFAULT:
        if (_dioError.error is SocketException) {
          // SocketException: Failed host lookup: '***'
          // (OS Error: No address associated with hostname, errno = 7)
          type = _ErrorType.network;
        } else {
          type = _ErrorType.unknown;
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        type = _ErrorType.timeout;
        break;
      case DioErrorType.SEND_TIMEOUT:
        type = _ErrorType.network;
        break;
      case DioErrorType.RESPONSE:
        switch (_dioError.response.statusCode) {
          case HttpStatus.badRequest: // 400
            type = _ErrorType.badRequest;
            break;
          case HttpStatus.unauthorized: // 401
            type = _ErrorType.unauthorized;
            break;
          case HttpStatus.internalServerError: // 500
          case HttpStatus.badGateway: // 502
          case HttpStatus.serviceUnavailable: // 503
          case HttpStatus.gatewayTimeout: // 504
            type = _ErrorType.server;
            break;
          default:
            type = _ErrorType.unknown;
            break;
        }
        break;
      case DioErrorType.CANCEL:
        type = _ErrorType.cancel;
        break;
      default:
        type = _ErrorType.unknown;
    }
    return type;
  }

  @override
  String get message => (_dioError.error?.toString() ?? '');

  @override
  String toString() {
    var msg = 'NetworkException [$errorType]: $message';
    final error = _dioError.error;
    if (error is Error) {
      msg += '\n${error.stackTrace}';
    }
    return msg;
  }
}

enum _ErrorType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}
