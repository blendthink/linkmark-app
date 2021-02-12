import 'package:linkmark_app/util/ext/async_snapshot.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockAsyncSnapshot extends Mock implements AsyncSnapshot {}

void main() {
  group('AsyncSnapshotExt Test', () {
    final mock = MockAsyncSnapshot();

    test('connectionState is none', () {
      when(mock.connectionState).thenReturn(ConnectionState.none);
      expect(mock.isNothing, isTrue);
      expect(mock.isActive, isFalse);
      expect(mock.isDone, isFalse);
      expect(mock.isWaiting, isFalse);
    });

    test('connectionState is active', () {
      when(mock.connectionState).thenReturn(ConnectionState.active);
      expect(mock.isNothing, isFalse);
      expect(mock.isActive, isTrue);
      expect(mock.isDone, isFalse);
      expect(mock.isWaiting, isFalse);
    });

    test('connectionState is done', () {
      when(mock.connectionState).thenReturn(ConnectionState.done);
      expect(mock.isNothing, isFalse);
      expect(mock.isActive, isFalse);
      expect(mock.isDone, isTrue);
      expect(mock.isWaiting, isFalse);
    });

    test('connectionState is waiting', () {
      when(mock.connectionState).thenReturn(ConnectionState.waiting);
      expect(mock.isNothing, isFalse);
      expect(mock.isActive, isFalse);
      expect(mock.isDone, isFalse);
      expect(mock.isWaiting, isTrue);
    });
  });
}
