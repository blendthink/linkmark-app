import 'package:dio/dio.dart';

import '../../../../util/logger.dart';
import '../app_exception.dart';
import '../unexpected/network_exception.dart';
import '../unexpected/unknown_exception.dart';

extension ExceptionExt on Exception {
  AppException toAppException() {
    logger.info(toString());
    final exception = this;

    if (exception is AppException) {
      return exception;
    } else if (exception is DioError) {
      return NetworkException(dioError: exception);
    } else {
      return const UnknownException();
    }
  }
}
