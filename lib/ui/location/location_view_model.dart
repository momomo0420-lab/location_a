import 'package:location_trial/app_container.dart';
import 'package:location_trial/data/model/date_model.dart';
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

  Future<void> getLocationsForDateRange(
    DateModel dateModel, {
    Function(List<LocationModel> locations)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = await ref.read(locationRepositoryProvider.future);
    final locations = await repository.findForDateRange(dateModel);

    if(onSuccess != null) onSuccess(locations);
  }

  Future<void> deleteLocation(
    int id,
    DateModel dateModel, {
    Function(List<LocationModel> locations)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = await ref.read(locationRepositoryProvider.future);
    await repository.deleteBy(id);

    final locations = await repository.findForDateRange(dateModel);

    if(onSuccess != null) onSuccess(locations);
  }
}
