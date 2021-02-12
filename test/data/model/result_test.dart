import 'package:linkmark_app/data/model/exception/app_exception.dart';
import 'package:linkmark_app/data/model/exception/unexpected/unexpected_call_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkmark_app/data/model/exception/unexpected/unknown_exception.dart';
import 'package:linkmark_app/data/model/result.dart';

class MockFunction extends Mock {
  void foo();
}

void main() {
  group('Result.success() Test', () {
    final result = const Result.success(data: 'success');
    final mock = MockFunction();

    test('isSuccess returns true', () {
      expect(result.isSuccess, isTrue);
    });

    test('isFailure returns false', () {
      expect(result.isFailure, isFalse);
    });

    test('ifSuccess() call once mock.foo()', () {
      result.ifSuccess((data) => mock.foo());
      verify(mock.foo()).called(1);
    });

    test('ifFailure() not call mock.foo()', () {
      result.ifFailure((e) => mock.foo());
      verifyNever(mock.foo());
    });

    test("dataOrThrow is 'success'", () {
      expect(result.dataOrThrow, 'success');
    });

    test("exception is UnexpectedCallException", () {
      expect(result.exception, isInstanceOf<UnexpectedCallException>());
    });
  });

  group('Result.failure() Test', () {
    final result = const Result.failure(exception: UnknownException());
    final mock = MockFunction();

    test('isSuccess returns false', () {
      expect(result.isSuccess, isFalse);
    });

    test('isFailure returns true', () {
      expect(result.isFailure, isTrue);
    });

    test('ifSuccess() not call mock.foo()', () {
      result.ifSuccess((data) => mock.foo());
      verifyNever(mock.foo());
    });

    test('ifFailure() call once mock.foo()', () {
      result.ifFailure((e) => mock.foo());
      verify(mock.foo()).called(1);
    });

    test("dataOrThrow throw UnknownException", () {
      expect(
          () => result.dataOrThrow, throwsA(isInstanceOf<UnknownException>()));
    });

    test("exception is AppException", () {
      expect(result.exception, isInstanceOf<AppException>());
    });
  });

  group('ResultObjectExt Test', () {
    test('asSuccess is Success', () {
      final data = 'data';
      final result = data.asSuccess;
      expect(result, isInstanceOf<Success>());
      expect(result.dataOrThrow, data);
    });
    test('asFailure is Failure', () {
      final data = 'data';
      final result = data.asFailure(Exception());
      expect(result, isInstanceOf<Failure>());
      expect(result.exception, isInstanceOf<AppException>());
    });
  });
}
