import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_state.freezed.dart';
part 'location_state.g.dart';

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

  factory LocationState.fromJson(Map<String, Object?> json)
    => _$LocationStateFromJson(json);
}