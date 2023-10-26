import 'package:flutter/material.dart';
import 'package:location_trial/ui/location/location_state.dart';
import 'package:location_trial/ui/location/location_view_model.dart';

class LocationBody extends StatelessWidget {
  final LocationViewModel _viewModel;
  final LocationState _state;

  const LocationBody({
    super.key,
    required LocationViewModel viewModel,
    required LocationState state,
  }): _viewModel = viewModel,
        _state = state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('経度：　${_state.longitude.toString()}'),
        const SizedBox(height: 16.0,),

        Text('経度：　${_state.latitude.toString()}'),
        const SizedBox(height: 16.0,),

        Text('現在地：　${_state.place}'),
        const SizedBox(height: 16.0,),

        ElevatedButton(
          onPressed: () => _viewModel.determinePosition(
            (position) => _viewModel.setPosition(position),
            () => null,
            (error) => debugPrint('LocationApp[LocationBody]: $error'),
          ),
          child: const Text('取得する'),
        ),
      ],
    );
  }
}
