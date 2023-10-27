import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/dao/location_handler.dart';
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
    // TODO: implement deleteBy
    throw UnimplementedError();
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
  Future<LocationModel> findBy(int id) async {
    final map = await _dao.findBy(id);
    return LocationModel.fromJson(map);
  }

  @override
  Future<LocationModel> getCurrentLocation() async {
    final currentPosition = await _handler.getCurrentPosition();

    final location = LocationModel(
      latitude: currentPosition?.latitude ?? 0,
      longitude: currentPosition?.longitude ?? 0,
      createAt: DateTime.now().millisecondsSinceEpoch,
    );

    final id = await insert(location);

    return location.copyWith(id: id);
  }
}