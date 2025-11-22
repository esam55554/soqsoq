import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper? _instance;
  static Database? _database;

  // Singleton instance getter
  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  // Database connection
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbFolder = await getDatabasesPath();
    final dbName = "ecommerce.db";
    final dbPath = join(dbFolder, dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create tables here
        await db.execute('''
          CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            price REAL NOT NULL,
            imageUrl Text  ,
            description Text,
           
          )
        ''');
        await db.execute('''
        INSERT INTO products (title, price, imageUrl, description)
        VALUES ('Product 1', 10.99, 'image_url_1', 'Description 1'),
               ('Product 2', 19.99, 'image_url_2', 'Description 2');
               ''');

      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database upgrades here
        if (oldVersion < newVersion) {
          // Add new tables or columns
        }
      },
    );
  }

  // Fetch all rows from a table
  Future<List<Map<String, dynamic>>> getFromTable({required String tableName}) async {
    try {
      final db = await database;
      return await db.query(tableName);
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  // Insert a row into a table
  Future<int> insertToTable({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    try {
      final db = await database;
      return await db.insert(tableName, data);
    } catch (e) {
      print('Error inserting data: $e');
      return -1;
    }
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}