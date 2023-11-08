import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'date_model.freezed.dart';
part 'date_model.g.dart';

@freezed
class DateModel with _$DateModel {
  const DateModel._();

  factory DateModel({
    @Default(0)
    int date,
  }) = _DateModel;

  factory DateModel.fromJson(Map<String, dynamic> json) => _$DateModelFromJson(json);

  /// 時刻（DateTime）を文字列に変換する
  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日')
        .format(DateTime.fromMillisecondsSinceEpoch(date));
  }
}