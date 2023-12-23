import 'package:hw4/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;
import 'dart:async';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'user.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE user (id INTEGER PRIMARY KEY, email TEXT, gender TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert('user', user.toJson());
  }

  Future<List<User>> get_user_list(String db_name) async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, db_name);

    Database database = await openDatabase(path, version: 1);

    List<Map> list = await database.rawQuery('SELECT * FROM user');
    return List.generate(list.length, (i) {
      return User(
        id: list[i]['id'],
        email: list[i]['email'],
        gender: list[i]['gender'],
      );
    });
  }
}
