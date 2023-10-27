import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/dao/location_dao_impl.dart';
import 'package:location_trial/data/dao/location_handler.dart';
import 'package:location_trial/data/dao/location_handler_impl.dart';
import 'package:location_trial/data/repository/location_repository.dart';
import 'package:location_trial/data/repository/location_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
LocationDao locationDao(LocationDaoRef ref) {
  return LocationDaoImpl();
}

@riverpod
LocationHandler locationHandler(LocationHandlerRef ref) {
  return LocationHandlerImpl();
}

@riverpod
LocationRepository locationRepository(LocationRepositoryRef ref) {
  return LocationRepositoryImpl(
      dao: ref.read(locationDaoProvider),
      handler: ref.read(locationHandlerProvider),
  );
}
