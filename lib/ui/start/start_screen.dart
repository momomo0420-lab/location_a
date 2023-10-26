import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_trial/ui/start/start_body.dart';
import 'package:location_trial/ui/start/start_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class StartScreen extends ConsumerWidget {
  final Function()? _navigateToNextScreen;

  const StartScreen({
    super.key,
    Function()? navigateToNextScreen,
  }): _navigateToNextScreen = navigateToNextScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(startViewModelProvider.notifier);
    final state = ref.watch(startViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('位置情報お試しアプリ'),
      ),
      body: StartBody(
        viewModel: viewModel,
        state: state,
        navigateToNextScreen: () => onStartButtonPressed(),
      ),
    );
  }

  void onStartButtonPressed() {
    if(_navigateToNextScreen != null) _navigateToNextScreen!();
  }
}
