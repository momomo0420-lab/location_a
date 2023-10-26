import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_view_model.g.dart';

@riverpod
class StartViewModel extends _$StartViewModel {
  @override
  PermissionStatus build() {
    return PermissionStatus.denied;
  }

  void setPermissionStatus(PermissionStatus status) {
    state = status;
  }

  Future<void> handleLocationPermission({
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    var status = await Permission.location.status;

    if(status.isGranted || status.isLimited) {
      if(onSuccess != null) onSuccess();
      return;
    }

    status = await Permission.location.request();

    if (status.isGranted || status.isLimited) {
      if(onSuccess != null) onSuccess();
      return;
    }

    if(onFailure != null) onFailure();
  }
}
