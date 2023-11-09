import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_trial/data/model/date_model.dart';

part 'date_list_state.freezed.dart';

@freezed
class DateListState with _$DateListState {
  const factory DateListState ({
    @Default(null)
    List<DateModel>? dateList,
    @Default(false)
    bool isRunning,
  }) = _DateListState;
}
