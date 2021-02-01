import 'package:dio/dio.dart';

import '../../../../util/logger.dart';
import '../app_exception.dart';
import '../unexpected/network_exception.dart';
import '../unexpected/unknown_exception.dart';

extension ExceptionExt on Exception {
  AppException toAppException() {
    logger.info(toString());
    if (this is AppException) {
      return this;
    } else if (this is DioError) {
      return NetworkException(dioError: this);
    } else {
      return const UnknownException();
    }
  }
}
