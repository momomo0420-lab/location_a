import 'package:location_trial/data/model/date_model.dart';
import 'package:location_trial/data/model/location_model.dart';

abstract class LocationRepository {
  Future<int> insert(LocationModel location);
  Future<void> update(LocationModel location);
  Future<void> deleteBy(int id);
  Future<List<LocationModel>> findAll();
  Future<List<DateModel>> findAllDate();
  Future<List<LocationModel>> findForDateRange(DateModel date);
  Future<LocationModel> findBy(int id);
  Future<LocationModel> getCurrentLocation();
}