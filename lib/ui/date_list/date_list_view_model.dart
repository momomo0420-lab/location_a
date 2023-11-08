import 'package:location_trial/app_container.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/ui/date_list/date_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_list_view_model.g.dart';

@riverpod
class DateListViewModel extends _$DateListViewModel {
  @override
  DateListState build() {
    return const DateListState();
  }

  void setDateList(List<DateModel> dateList) {
    state = state.copyWith(dateList: dateList);
  }

  Future<void> getDateList({
    Function(List<DateModel> dateList)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = ref.read(locationRepositoryProvider);
    final dateList = await repository.findAllDate();

    if(onSuccess != null) onSuccess(dateList);
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

    if(onSuccess != null) onSuccess();
  }
}
