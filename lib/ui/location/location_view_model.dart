import 'package:geocoding/geocoding.dart';
import 'package:location_trial/app_container.dart';
import 'package:location_trial/data/model/location_model.dart';
import 'package:location_trial/ui/location/location_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_view_model.g.dart';

@riverpod
class LocationViewModel extends _$LocationViewModel {
  @override
  LocationState build() {
    return const LocationState();
  }

  Future<void> setLocation(LocationModel location) async {
    final placeMarks = await placemarkFromCoordinates(location.latitude, location.longitude);

    final placeMark = placeMarks[0];
    final place = placeMark.street;

    state = state.copyWith(
      longitude: location.longitude,
      latitude: location.latitude,
      place: (place != null) ? place : '',
    );
  }

  Future<void> getCurrentLocation(
    Function(LocationModel location)? onSuccess,
    Function()? onLoading,
    Function(String error)? onFailure,
  ) async {
    if(onLoading != null) onLoading();

    final repository = ref.read(locationRepositoryProvider);
    final location = await repository.getCurrentLocation();

    if(onSuccess != null) onSuccess(location);
  }
}
