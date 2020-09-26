import 'package:my_sqlite/sqlite/database_helper.dart';

class UsersModel{

  int id;
  String userName;

  UsersModel({this.id, this.userName});

  factory UsersModel.fromMap(Map<String, dynamic> map){
    UsersModel userModel = UsersModel(id : map[DBHelper.id], userName : map[DBHelper.userName]);
    return userModel;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map[DBHelper.id] = id;
    map[DBHelper.userName] = userName;
    return map;
  }

}