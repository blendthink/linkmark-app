import 'package:freezed_annotation/freezed_annotation.dart';

part 'link.freezed.dart';

part 'link.g.dart';

@freezed
abstract class Link with _$Link {
  factory Link({
    @required String url,
    String title,
    String description,
    String imageUrl,
  }) = _Link;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}
