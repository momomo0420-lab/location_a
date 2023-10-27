import 'package:location_trial/data/model/location_model.dart';

abstract class LocationRepository {
  Future<int> insert(LocationModel location);
  Future<void> update(LocationModel location);
  Future<void> deleteBy(int id);
  Future<List<LocationModel>> findAll();
  Future<LocationModel> findBy(int id);
  Future<LocationModel> getCurrentLocation();
}