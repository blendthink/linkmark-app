import 'package:flutter_test/flutter_test.dart';
import 'package:linkmark_app/data/model/link.dart';

void main() {
  group('Link fromJson Test', () {
    group('success', () {
      test('all value is non empty', () {
        const id = "id";
        const url = "url";
        const title = "title";
        const description = "description";
        const imageUrl = "imageUrl";
        const tagIds = ["tagIds"];

        final json = {
          "id": id,
          "url": url,
          "title": title,
          "description": description,
          "imageUrl": imageUrl,
          "tagIds": tagIds,
        };

        final actual = Link.fromJson(json);

        expect(actual.id, id);
        expect(actual.url, url);
        expect(actual.title, title);
        expect(actual.description, description);
        expect(actual.imageUrl, imageUrl);
        expect(actual.tagIds, tagIds);
      });

      group('title', () {
        test('value is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": null,
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.title, '');
        });

        test('key is null', () {
          final json = {
            "id": "",
            "url": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.title, '');
        });
      });

      group('description', () {
        test('value is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": null,
            "imageUrl": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.description, '');
        });

        test('key is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "imageUrl": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.description, '');
        });
      });

      group('imageUrl', () {
        test('value is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": null,
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.imageUrl, null);
        });

        test('key is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.imageUrl, null);
        });
      });

      group('tagIds', () {
        test('value is empty', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          final actual = Link.fromJson(json);

          expect(actual.tagIds, List.empty());
        });

        test('value is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": null,
          };

          final actual = Link.fromJson(json);

          expect(actual.tagIds, null);
        });

        test('key is null', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
          };

          final actual = Link.fromJson(json);

          expect(actual.tagIds, null);
        });
      });
    });

    group('failure', () {
      group('id', () {
        test('value is null', () {
          final json = {
            "id": null,
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsAssertionError);
        });

        test('key is null', () {
          final json = {
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsAssertionError);
        });

        test('type is num', () {
          final json = {
            "id": 1,
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('url', () {
        test('value is null', () {
          final json = {
            "id": "",
            "url": null,
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsAssertionError);
        });

        test('key is null', () {
          final json = {
            "id": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsAssertionError);
        });

        test('type is num', () {
          final json = {
            "id": "",
            "url": 1,
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('title', () {
        test('type is num', () {
          final json = {
            "id": "",
            "url": "",
            "title": 1,
            "description": "",
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('description', () {
        test('type is num', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": 1,
            "imageUrl": "",
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('imageUrl', () {
        test('type is num', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": 1,
            "tagIds": [],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });

      group('tagIds', () {
        test('type is string', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": "",
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });

        test('type is num', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": 1,
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });

        test('value type is num', () {
          final json = {
            "id": "",
            "url": "",
            "title": "",
            "description": "",
            "imageUrl": "",
            "tagIds": [1],
          };

          expect(() => Link.fromJson(json), throwsA(isA<TypeError>()));
        });
      });
    });
  });
}
