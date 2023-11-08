import 'package:flutter/material.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/data/model/location_model.dart';
import 'package:location_trial/ui/location/location_state.dart';
import 'package:location_trial/ui/location/location_view_model.dart';

class LocationBody extends StatelessWidget {
  final LocationViewModel _viewModel;
  final LocationState _state;
  final DateModel _dateModel;

  const LocationBody({
    super.key,
    required LocationViewModel viewModel,
    required LocationState state,
    required DateModel dateModel,
  }): _viewModel = viewModel,
        _state = state,
        _dateModel = dateModel;

  @override
  Widget build(BuildContext context) {
    if(_state.locations == null) {
      _viewModel.getLocationsForDateRange(
        _dateModel,
        onSuccess: (locations) => _viewModel.setLocations(locations),
      );
    }

    return buildLocationList(
      locations: _state.locations,
      onTap: (id) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('id: $idのリストが押下されました。')),
        );
      },
      onDeleteIconTap: (id) => _viewModel.deleteLocation(id: id),
    );
  }

  Widget buildLocationList({
    required List<LocationModel>? locations,
    Function(int id)? onTap,
    Function(int id)? onDeleteIconTap,
  }) {
    if(locations == null) {
      return const Center(child: Text('Now Loading...'));
    }

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
      leading: const Icon(
        Icons.place,
        color: Colors.red,
      ),
      title: Text(location.getFormattedDate()),
      subtitle: Text(location.place),
      trailing: InkWell(
        child: const Icon(Icons.delete),
        onTap: () {
          if(onDeleteIconTap != null) onDeleteIconTap(location.id ?? 0);
        },
      ),
      onTap: () {
        if(onTap != null) onTap(location.id ?? 0);
      },
    );
  }
}
