import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:linkmark_app/data/model/exception/app_exception.dart';
import 'package:linkmark_app/data/model/exception/expected_exption.dart';
import 'package:linkmark_app/data/model/exception/unexpected/network_exception.dart';
import 'package:linkmark_app/data/model/exception/unexpected/unknown_exception.dart';
import 'package:linkmark_app/util/logger.dart';

class AppError {
  AppException _exception;

  bool get hasSolution => _exception is ExpectedException;

  String get message => _exception.message;

  String get solution {
    final e = _exception;
    if (e is ExpectedException) {
      return e.solution;
    } else {
      return null;
    }
  }

  AppError({
    @required Exception exception,
  }) {
    logger.info(exception.toString());

    if (exception is AppException) {
      this._exception = exception;
    } else if (exception is DioError) {
      this._exception = NetworkException(dioError: exception);
    } else {
      this._exception = const UnknownException();
    }
  }
}
