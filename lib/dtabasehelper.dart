import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal() {
    initDatabase(); // Initialize the database in the constructor
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      throw Exception("Database not initialized.");
    }
  }

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'your_database_name.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE CardItem (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            desc TEXT,
            price REAL,
            qty INTEGER,
            discount REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE Product (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            desc TEXT,
            price REAL,
            qty INTEGER,
            discount REAL
          )
        ''');

        await db.execute('''
      CREATE TABLE  Bookings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_name TEXT,
        booking_date TEXT,
        room_number INTEGER,
        check_in TEXT,
        check_out TEXT
      )
    ''');
        // Add more tables if needed
      },
    );
  }
}
