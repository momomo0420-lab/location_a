import 'package:location_trial/data/dao/location_dao.dart';
import 'package:location_trial/data/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class LocationDaoImpl implements LocationDao {
  final Database _db;

  const LocationDaoImpl({
    required Database db,
  }): _db = db;

  @override
  Future<int> insert(Map<String, dynamic> location) async {
    return _db.insert(
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
    await _db.delete(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    return await _db.query(
      DatabaseHelper.tableName,
      orderBy: '${LocationDatabaseColumns.createAt.column} DESC',
    );
  }

  @override
  Future<Map<String, dynamic>> findBy(int id) async {
    final maps = await _db.query(
      DatabaseHelper.tableName,
      where: '${LocationDatabaseColumns.id.column} = ?',
      whereArgs: [id],
    );

    return maps.first;
  }

  @override
  Future<List<Map<String, dynamic>>> findAllDate() async {
    final rows = await _db.rawQuery('''
      SELECT ${LocationDatabaseColumns.createAt.column} AS date
      FROM ${DatabaseHelper.tableName}
    ''');

    return rows;
  }

  @override
  Future<List<Map<String, dynamic>>> findForDateRange(
    int from,
    int to,
  ) async {
    return await _db.query(
      DatabaseHelper.tableName,
      where: '''${LocationDatabaseColumns.createAt.column} >= ? 
              AND ${LocationDatabaseColumns.createAt.column} < ?''',
      whereArgs: [from, to],
      orderBy: '${LocationDatabaseColumns.createAt.column} ASC',
    );
  }
}