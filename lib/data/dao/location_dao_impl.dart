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
    final db = await _dbHelper.db;
    await db.delete(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
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

  @override
  Future<List<Map<String, dynamic>>> findAllDate() async {
    final db = await _dbHelper.db;

    final rows = await db.rawQuery('''
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
    final db = await _dbHelper.db;

    return await db.query(
      DatabaseHelper.tableName,
      where: '''${LocationDatabaseColumns.createAt.column} >= ? 
              AND ${LocationDatabaseColumns.createAt.column} < ?''',
      whereArgs: [from, to],
      orderBy: '${LocationDatabaseColumns.createAt.column} ASC',
    );
  }
}