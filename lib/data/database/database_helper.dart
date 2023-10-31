import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum LocationDatabaseColumns {
  id('id'),
  latitude('latitude'),
  longitude('longitude'),
  place('place'),
  createAt('create_at'),
  ;

  final String column;

  const LocationDatabaseColumns(this.column);
}

class DatabaseHelper {
  // シングルトン管理
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static const databaseName = 'location_trial.db';
  static const databaseVer = 1;
  static const tableName = 'location_table';

  // データベース
  static Database? _db;
  Future<Database> get db async {
    // 初期化が完了しているなら保持しているデータベースを返却
    if(_db != null) {
      return _db!;
    }

    // 初期化を行い、データベースを返却
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);
    _db = await openDatabase(
      path,
      version: databaseVer,
      onCreate: _onCreate,
    );

    return _db!;
  }

  /// テーブル作成
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${LocationDatabaseColumns.id.column} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${LocationDatabaseColumns.latitude.column} REAL,
        ${LocationDatabaseColumns.longitude.column} REAL,
        ${LocationDatabaseColumns.place.column} TEXT,
        ${LocationDatabaseColumns.createAt.column} INTEGER
      )
    ''');
  }

}