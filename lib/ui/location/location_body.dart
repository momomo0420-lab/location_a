import 'package:flutter/material.dart';
import 'package:location_trial/data/model/location_model.dart';
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
        ElevatedButton(
          onPressed: () => _viewModel.updateLocations(),
          child: const Text('取得する'),
        ),

        buildLocationList(
          locations: _state.locations,
          onTap: (id) {},
          onDeleteIconTap: (id) => _viewModel.deleteLocation(id: id),
        ),
      ],
    );
  }

  Widget buildLocationList({
    required List<LocationModel> locations,
    Function(int id)? onTap,
    Function(int id)? onDeleteIconTap,
  }) {
    final tiles = <Widget>[];

    for(var location in locations) {
      final tile = buildLocationTile(
        location: location,
        onTap: onTap,
        onDeleteIconTap: onDeleteIconTap,
      );
      tiles.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tile,
        )
      );
    }
    return ListView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => tiles[index],
    );
  }

  Widget buildLocationTile({
    required LocationModel location,
    Function(int id)? onTap,
    Function(int id)? onDeleteIconTap,
  }) {
    return ListTile(
      leading: const Icon(Icons.place),
      title: Text(location.getFormattedDate()),
      subtitle: Text(location.place),
      trailing: InkWell(
        onTap: () {
          if(onDeleteIconTap != null) onDeleteIconTap(location.id ?? 0);
        },
        child: const Icon(Icons.delete),
      ),
      onTap: () {
        if(onTap != null) onTap(location.id ?? 0);
      },
    );
  }
}
