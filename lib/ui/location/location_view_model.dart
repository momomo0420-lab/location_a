import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_trial/ui/location/location_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_view_model.g.dart';

@riverpod
class LocationViewModel extends _$LocationViewModel {
  @override
  LocationState build() {
    return const LocationState();
  }

  Future<void> setPosition(Position position) async {
    final placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    final placeMark = placeMarks[0];
    final place = placeMark.street;

    state = state.copyWith(
      longitude: position.longitude,
      latitude: position.latitude,
      place: (place != null) ? place : '',
    );
  }

  Future<void> determinePosition(
    Function(Position position)? onSuccess,
    Function()? onLoading,
    Function(String error)? onFailure,
  ) async {
    if(onLoading != null) onLoading();

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if(onFailure != null) onFailure('Location services are disabled. 1');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        if(onFailure != null) onFailure('Location permissions are denied. 2');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      if(onFailure != null) {
        onFailure('Location permissions are permanently denied, we cannot request permissions.');
        return;
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    if(onSuccess != null) onSuccess(position);
  }
}
