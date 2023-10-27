import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const LocationModel._();

  const factory LocationModel({
    int? id,
    @Default(0.0)
    double latitude,
    @Default(0.0)
    double longitude,
    @Default(0)
    @JsonKey(name: 'create_at')
    int createAt,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  /// 時刻（DateTime）を文字列に変換する
  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日')
        .format(DateTime.fromMillisecondsSinceEpoch(createAt));
  }
}