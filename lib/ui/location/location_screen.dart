import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/ui/location/location_body.dart';
import 'package:location_trial/ui/location/location_view_model.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateModel = ModalRoute.of(context)!.settings.arguments as DateModel;

    final viewModel = ref.read(locationViewModelProvider.notifier);
    final state = ref.watch(locationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(dateModel.getFormattedDate()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LocationBody(
          viewModel: viewModel,
          state: state,
          dateModel: dateModel,
        ),
      ),
    );
  }
}
