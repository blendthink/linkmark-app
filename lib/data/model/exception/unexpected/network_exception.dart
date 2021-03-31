import 'dart:io';

import 'package:dio/dio.dart';
import '../unexpected_exception.dart';

enum NetworkExceptionType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}

class NetworkException implements UnexpectedException {
  final DioError _dioError;

  NetworkException({
    required DioError dioError,
  }) : _dioError = dioError;

  NetworkExceptionType get type {
    NetworkExceptionType type;
    switch (_dioError.type) {
      case DioErrorType.DEFAULT:
        if (_dioError.error is SocketException) {
          // SocketException: Failed host lookup: '***'
          // (OS Error: No address associated with hostname, errno = 7)
          type = NetworkExceptionType.network;
        } else {
          type = NetworkExceptionType.unknown;
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        type = NetworkExceptionType.timeout;
        break;
      case DioErrorType.SEND_TIMEOUT:
        type = NetworkExceptionType.network;
        break;
      case DioErrorType.RESPONSE:
        switch (_dioError.response.statusCode) {
          case HttpStatus.badRequest: // 400
            type = NetworkExceptionType.badRequest;
            break;
          case HttpStatus.unauthorized: // 401
            type = NetworkExceptionType.unauthorized;
            break;
          case HttpStatus.internalServerError: // 500
          case HttpStatus.badGateway: // 502
          case HttpStatus.serviceUnavailable: // 503
          case HttpStatus.gatewayTimeout: // 504
            type = NetworkExceptionType.server;
            break;
          default:
            type = NetworkExceptionType.unknown;
            break;
        }
        break;
      case DioErrorType.CANCEL:
        type = NetworkExceptionType.cancel;
        break;
      default:
        type = NetworkExceptionType.unknown;
    }
    return type;
  }

  @override
  String get message => _dioError.message;

  @override
  String toString() {
    var msg = 'NetworkException [$type]: $message';
    final error = _dioError.error;
    if (error is Error) {
      msg += '\n${error.stackTrace}';
    }
    return msg;
  }
}
