import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_trial/data/model/location_model.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(<LocationModel>[])
    List<LocationModel> locations,
  }) = _LocationState;
}