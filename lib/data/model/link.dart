import 'package:freezed_annotation/freezed_annotation.dart';

part 'link.freezed.dart';

part 'link.g.dart';

@freezed
abstract class Link with _$Link {
  const factory Link({
    required String id,
    required String url,
    @Default('') String title,
    @Default('') String description,
    String? imageUrl,
    List<String>? tagIds,
  }) = _Link;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}
