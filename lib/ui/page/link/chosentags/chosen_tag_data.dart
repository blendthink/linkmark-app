import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/model/tag.dart';

part 'chosen_tag_data.freezed.dart';

@freezed
abstract class ChosenTagData with _$ChosenTagData {
  const factory ChosenTagData({
    @required Tag tag,
    @required bool isChosen,
  }) = _ChosenTagData;
}
