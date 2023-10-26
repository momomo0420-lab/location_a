import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:location_trial/ui/start/start_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class StartBody extends StatelessWidget {
  final StartViewModel _viewModel;
  final PermissionStatus _state;
  final Function()? _navigateToNextScreen;

  const StartBody({
    super.key,
    required StartViewModel viewModel,
    required PermissionStatus state,
    Function()? navigateToNextScreen,
  }): _viewModel = viewModel,
        _state = state,
        _navigateToNextScreen = navigateToNextScreen;

  @override
  Widget build(BuildContext context) {
    _viewModel.handleLocationPermission(
      onSuccess: onLocationPermissionSuccess,
    );

    return Center(
      child: ElevatedButton(
        onPressed: () => _viewModel.handleLocationPermission(
          onSuccess: onLocationPermissionSuccess,
          onFailure: () => onLocationPermissionFailure(context),
        ),
        child: const Text('START'),
      ),
    );
  }

  void onLocationPermissionSuccess() {
    if(_navigateToNextScreen != null) _navigateToNextScreen!();
  }

  void onLocationPermissionFailure(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('注意'),
        content: const Text('アプリを使用する場合は位置情報の権限を許可してください。'),
        actions: [
          TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('設定画面を開く')
          ),

          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
