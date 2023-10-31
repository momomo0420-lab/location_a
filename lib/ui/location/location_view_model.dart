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

  void setLocations(List<LocationModel> locations) {
    state = state.copyWith(locations: locations);
  }

  Future<void> updateLocations({
    Function()? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = ref.read(locationRepositoryProvider);
    final location = await repository.getCurrentLocation();

    await repository.insert(location);
    final locations = await repository.findAll();

    setLocations(locations);

    if(onSuccess != null) onSuccess();
  }

  Future<void> deleteLocation({
    required int id,
    Function()? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = ref.read(locationRepositoryProvider);
    await repository.deleteBy(id);

    final locations = await repository.findAll();
    setLocations(locations);

    if(onSuccess != null) onSuccess();
  }
}
