import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class LocationDaoImpl implements LocationDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Future<int> insert(Map<String, dynamic> location) async {
    final db = await _dbHelper.db;
    return db.insert(
      DatabaseHelper.tableName,
      location,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(int id, Map<String, dynamic> location) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBy(int id) async {
    // TODO: implement deleteBy
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    final db = await _dbHelper.db;
    
    return await db.query(
      DatabaseHelper.tableName,
      orderBy: '${LocationDatabaseColumns.createAt.column} DESC',
    );
  }

  @override
  Future<Map<String, dynamic>> findBy(int id) async {
    final db = await _dbHelper.db;

    final maps = await db.query(
      DatabaseHelper.tableName,
      where: '${LocationDatabaseColumns.id.column} = ?',
      whereArgs: [id],
    );

    return maps.first;
  }
}