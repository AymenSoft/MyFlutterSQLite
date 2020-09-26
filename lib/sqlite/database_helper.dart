import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  static final _databaseName = "my_sql_app.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  //tables names
  static final tableUsers = 'tableUsers';

  //users table columns
  static final id = "id";
  static final userName = 'userName';

  //create table users
  static final String createTableUsers = '''CREATE TABLE $tableUsers (
            $id INTEGER PRIMARY KEY AUTOINCREMENT, 
            $userName STRING
          )''';

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(createTableUsers);
  }


}