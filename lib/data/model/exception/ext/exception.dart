import 'package:dio/dio.dart';
import 'package:linkmark_app/data/model/exception/app_exception.dart';
import 'package:linkmark_app/data/model/exception/unexpected/network_exception.dart';
import 'package:linkmark_app/data/model/exception/unexpected/unknown_exception.dart';
import 'package:linkmark_app/util/logger.dart';

extension ExceptionExt on Exception {
  AppException toAppException() {
    logger.info(this.toString());
    if (this is AppException) {
      return this;
    } else if (this is DioError) {
      return NetworkException(dioError: this);
    } else {
      return const UnknownException();
    }
  }
}
