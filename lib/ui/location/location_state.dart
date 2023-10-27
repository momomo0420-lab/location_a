import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(0.0)
    double latitude,
    @Default(0.0)
    double longitude,
    @Default('')
    String place,
  }) = _LocationState;
}