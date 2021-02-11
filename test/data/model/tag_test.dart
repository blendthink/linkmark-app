import 'package:flutter_test/flutter_test.dart';
import 'package:linkmark_app/data/model/tag.dart';

void main() {
  group('Tag fromJson Test', () {
    group('success', () {
      test('all value is non empty', () {
        const id = "id";
        const name = "name";
        const order = 1;

        final json = {
          "id": id,
          "name": name,
          "order": order,
        };

        final actual = Tag.fromJson(json);

        expect(actual.id, id);
        expect(actual.name, name);
        expect(actual.order, order);
      });
    });

    group('failure', () {
      group('id', () {
        test('value is null', () {
          final json = {
            "id": null,
            "name": "",
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('key is null', () {
          final json = {
            "name": "",
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('type is num', () {
          final json = {
            "id": 1,
            "name": "",
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('name', () {
        test('value is null', () {
          final json = {
            "id": "",
            "name": null,
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('key is null', () {
          final json = {
            "id": "",
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('type is num', () {
          final json = {
            "id": "",
            "name": 1,
            "order": 1,
          };

          expect(() => Tag.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('order', () {
        test('value is null', () {
          final json = {
            "id": "",
            "name": "",
            "order": null,
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('key is null', () {
          final json = {
            "id": "",
            "name": "",
          };

          expect(() => Tag.fromJson(json), throwsAssertionError);
        });

        test('type is string', () {
          final json = {
            "id": "",
            "name": "",
            "order": "",
          };

          expect(() => Tag.fromJson(json), throwsA(isA<TypeError>()));
        });
      });
    });
  });
}
