import 'package:my_sqlite/models/users_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class UsersDB{

  DBHelper dbHelper;

  UsersDB(){
    dbHelper = DBHelper.instance;
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> user) async {
    Database db = await dbHelper.database;
    return await db.insert(DBHelper.tableUsers, user);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> user) async {
    Database db = await dbHelper.database;
    int id = user[DBHelper.id];
    print("update id: $user");
    return await db.update(DBHelper.tableUsers, user, where: DBHelper.id +' = ?', whereArgs: [id]);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<UsersModel>> getAll() async {
    Database db = await dbHelper.database;
    var result = await db.query(DBHelper.tableUsers, orderBy: DBHelper.userName + " ASC");
    List<UsersModel> list = List<UsersModel>();
    result.forEach((element) {
      UsersModel usersModel = UsersModel.fromMap(element);
      list.add(usersModel);
    });
    return list;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete(DBHelper.tableUsers, where: DBHelper.id + ' = ?', whereArgs: [id]);
  }

  // Deletes all rows. The number of affected rows is
  // returned. This shouldn't be 0 as long as rows exists.
  Future<int> deleteAll() async {
    Database db = await dbHelper.database;
    return await db.delete(DBHelper.tableUsers);
  }

}