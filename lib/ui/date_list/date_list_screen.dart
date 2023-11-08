import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/ui/date_list/date_list_body.dart';
import 'package:location_trial/ui/date_list/date_list_view_model.dart';

class DateListScreen extends ConsumerWidget {
  final Function(DateModel dateModel)? _navigateToNextScreen;

  const DateListScreen({
    super.key,
    Function(DateModel dateModel)? navigateToNextScreen,
  }): _navigateToNextScreen = navigateToNextScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(dateListViewModelProvider.notifier);
    final state = ref.watch(dateListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('位置情報お試しアプリ'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.updateLocations();
            },
            icon: const Icon(Icons.play_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DateListBody(
          viewModel: viewModel,
          state: state,
          navigateToNextScreen: _navigateToNextScreen,
        ),
      ),
    );
  }
}
