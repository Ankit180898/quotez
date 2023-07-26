import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../Models/saved_item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }


  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final pathToDatabase = path.join(databasesPath, 'my_database.db');

    return await openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items (
            text TEXT,
            author TEXT,
            category TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertItem(Item item) async {
    final db = await database;
    int insertedRowId = await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Inserted Row ID: $insertedRowId');
    return insertedRowId;
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (index) {
      return Item.fromMap(maps[index]);
    });
  }

  Future<void> removeItem(String item) async {
    final db = await database;
    await db.delete('items', where: 'author = ?', whereArgs: [item]);
  }
}
