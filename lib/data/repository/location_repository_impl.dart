import 'package:geocoding/geocoding.dart';
import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/dao/location_handler.dart';
import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/data/model/location_model.dart';
import 'package:location_trial/data/repository/location_repository.dart';


class LocationRepositoryImpl implements LocationRepository {
  final LocationDao _dao;
  final LocationHandler _handler;

  const LocationRepositoryImpl({
    required LocationDao dao,
    required LocationHandler handler,
  }): _dao = dao,
        _handler = handler;

  @override
  Future<int> insert(LocationModel location) async {
    return await _dao.insert(location.toJson());
  }

  @override
  Future<void> update(LocationModel location) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBy(int id) async {
    await _dao.deleteBy(id);
  }

  @override
  Future<List<LocationModel>> findAll() async {
    final maps = await _dao.findAll();

    final locationList = <LocationModel>[];
    for(var map in maps) {
      locationList.add(LocationModel.fromJson(map));
    }

    return locationList;
  }

  @override
  Future<List<LocationModel>> findForDateRange(DateModel date) async {
    var temp = DateTime.fromMillisecondsSinceEpoch(date.date);
    final dateTime = DateTime(
      temp.year,
      temp.month,
      temp.day,
    );
    final from = dateTime.millisecondsSinceEpoch;
    final to = dateTime.add(const Duration(days: 1)).millisecondsSinceEpoch;

    final rows = await _dao.findForDateRange(from, to);

    final locationList = <LocationModel>[];
    for(var row in rows) {
      locationList.add(LocationModel.fromJson(row));
    }

    return locationList;
  }

  @override
  Future<List<DateModel>> findAllDate() async {
    final maps = await _dao.findAllDate();

    final dateList = <DateModel>[];
    String lastDateStr = '';

    for(var map in maps) {
      final date = DateModel.fromJson(map);
      final dateStr = date.getFormattedDate();
      
      if(dateStr != lastDateStr) {
        dateList.add(date);
        lastDateStr = dateStr;
      }
    }

    return dateList;
  }

  @override
  Future<LocationModel> findBy(int id) async {
    final map = await _dao.findBy(id);
    return LocationModel.fromJson(map);
  }

  @override
  Future<LocationModel> getCurrentLocation() async {
    final currentPosition = await _handler.getCurrentPosition();

    final longitude = currentPosition?.longitude ?? 0;
    final latitude = currentPosition?.latitude ?? 0;

    final place = await _getPlace(longitude, latitude);

    return LocationModel(
      latitude: latitude,
      longitude: longitude,
      place: place,
      createAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String> _getPlace(
    double longitude,
    double latitude,
  ) async {
    final placeMarks = await placemarkFromCoordinates(latitude, longitude);
    final place = placeMarks[0].street;
    return (place != null)? place : '';
  }

}