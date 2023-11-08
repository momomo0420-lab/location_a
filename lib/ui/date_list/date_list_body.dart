import 'package:flutter/material.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/ui/date_list/date_list_state.dart';
import 'package:location_trial/ui/date_list/date_list_view_model.dart';

class DateListBody extends StatelessWidget {
  final DateListViewModel _viewModel;
  final DateListState _state;
  final Function(DateModel date)? _navigateToNextScreen;

  const DateListBody({
    super.key,
    required DateListViewModel viewModel,
    required DateListState state,
    Function(DateModel)? navigateToNextScreen,
  }): _viewModel = viewModel,
        _state = state,
        _navigateToNextScreen = navigateToNextScreen;

  @override
  Widget build(BuildContext context) {
    if(_state.dateList == null) {
      _viewModel.getDateList(
        onSuccess: (dateList) => _viewModel.setDateList(dateList),
      );
    }

    return buildDateList(
      dateList: _state.dateList,
      onTap: (date) {
        if(_navigateToNextScreen != null) _navigateToNextScreen!(date);
      },
    );
  }

  Widget buildDateList({
    List<DateModel>? dateList,
    Function(DateModel date)? onTap,
  }) {
    if(dateList == null) {
      return const Center(child: Text('Now Loading...'));
    }

    final tiles = <Widget>[];

    for(var date in dateList) {
      final tile = buildDateTile(
        date: date,
        onTap: onTap,
      );
      tiles.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: tile,
      ));
    }

    return ListView.builder(
      itemCount: tiles.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => tiles[index],
    );
  }

  Widget buildDateTile({
    required DateModel date,
    Function(DateModel date)? onTap,
  }) {
    return ListTile(
      title: Text(date.getFormattedDate()),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        if(onTap != null) onTap(date);
      },
    );
  }
}
