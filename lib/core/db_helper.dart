import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'confhub.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE events (
    eventid INTEGER PRIMARY KEY,
    title TEXT,
    category TEXT,
    location TEXT,
    datetime TEXT, -- Guardaremos la fecha y hora como una cadena en formato ISO 8601
    attendees INTEGER,
    availableSpots INTEGER,
    description TEXT,
    speakerName TEXT,
    speakerAvatar TEXT,
    sessionOrder TEXT, -- Guardaremos el JSON como una cadena
    tags TEXT, -- Guardaremos el array como una cadena separada por comas
    avgScore REAL,
    numberReviews INTEGER,
    status TEXT
  )
''');

    await db.execute('''
    CREATE TABLE feedbacks (
      id INTEGER PRIMARY KEY AUTOINCREMENT, -- ID autoincremental
      eventid INTEGER,
      title TEXT,
      comment TEXT,
      score INTEGER,
      datetime TEXT, -- Fecha y hora en formato ISO 8601
      likes INTEGER,
      dislikes INTEGER,
      answer TEXT
    )
  ''');
  }
}
