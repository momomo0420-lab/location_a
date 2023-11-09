import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/dao/location_dao_impl.dart';
import 'package:location_trial/data/dao/location_handler.dart';
import 'package:location_trial/data/dao/location_handler_impl.dart';
import 'package:location_trial/data/database/database_helper.dart';
import 'package:location_trial/data/repository/location_repository.dart';
import 'package:location_trial/data/repository/location_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'app_container.g.dart';

@riverpod
LocationHandler locationHandler(LocationHandlerRef ref) {
  return LocationHandlerImpl();
}

@riverpod
Future<Database> locationDatabase(LocationDatabaseRef ref) async {
  final db = await DatabaseHelper().db;
  return db;
}

@riverpod
Future<LocationDao> locationDao(LocationDaoRef ref) async {
  final db = await ref.read(locationDatabaseProvider.future);

  return LocationDaoImpl(db: db);
}

@riverpod
Future<LocationRepository> locationRepository(LocationRepositoryRef ref) async {
  final dao = await ref.read(locationDaoProvider.future);
  final handler = ref.read(locationHandlerProvider);

  return LocationRepositoryImpl(
    dao: dao,
    handler: handler,
  );
}