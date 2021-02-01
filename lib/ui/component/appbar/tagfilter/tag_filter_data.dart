import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/model/tag.dart';

part 'tag_filter_data.freezed.dart';
part 'tag_filter_data.g.dart';

@freezed
abstract class TagFilterData with _$TagFilterData {
  const factory TagFilterData({
    @required bool selected,
    @required Tag tag,
  }) = _TagFilterData;

  factory TagFilterData.fromJson(Map<String, dynamic> json) =>
      _$TagFilterDataFromJson(json);
}
