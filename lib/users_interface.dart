import 'package:flutter/material.dart';
import 'package:my_sqlite/sqlite/database_helper.dart';
import 'package:my_sqlite/sqlite/users_database.dart';

import 'models/users_model.dart';

class UsersInterface extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return UsersState();
  }

}

class UsersState extends State<UsersInterface>{

  final DBHelper dbHelper = DBHelper.instance;

  Future<List<UsersModel>> usersList;

  @override
  Widget build(BuildContext context) {

    //import users list from sqlite database
    usersList = UsersDB().getAll();

    return Scaffold(
      appBar: AppBar(
        title: Text("My SQLITE"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Wrap(
              spacing: 10,
              children: <Widget>[
                RaisedButton(
                  child: Text("refresh"),
                  onPressed: (){
                    refreshInterface();
                  },
                ),
                RaisedButton(
                  child: Text("insert"),
                  onPressed: (){
                    insert();
                  },
                ),
                RaisedButton(
                  child: Text("delete all"),
                  onPressed: (){
                    deleteAll();
                  },
                ),
              ],
            ),
            Expanded(
              flex: 8,
              child: futureBuilder(),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder futureBuilder(){
    return FutureBuilder<List<UsersModel>>(
      future: usersList,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder:(context, position){
                UsersModel usersModel = snapshot.data[position];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.redAccent),
                  onDismissed: (direction){
                    int id = usersModel.id;
                    delete(id);
                    debugPrint("user id: $id");
                    debugPrint("direction: $direction");
                  },
                  child: ListTile(
                    leading: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 40
                    ),
                    title: Text(usersModel.userName),
                    //tap to update item
                    onTap: (){
                      int id = usersModel.id;
                      String userName = usersModel.userName;
                      debugPrint("user $id : $userName");
                      update(usersModel);
                    },
                  ),
                );
              }
          );
        }else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  //refresh list view
  refreshInterface(){
    print("refresh");
    setState(() {});
  }

  //insert new entry in database
   insert()async{
    UsersModel usersModel = UsersModel();
    usersModel.userName = "USER NAME";
    final id = await UsersDB().insert(usersModel.toMap());
    print(id);
    refreshInterface();
  }

  //update selected entry
  update(UsersModel user)async{
    user.userName = "UPDATED NAME";
    print("user ${user.id}: ${user.userName}");
    final id = await UsersDB().update(user.toMap());
    print("updated: $id");
    refreshInterface();
  }

  //delete items by id
  delete(int id)async{
    final row = await UsersDB().delete(id);
    print("delete row : $row");
    refreshInterface();
  }

  //delete all
  deleteAll()async{
    final rows = await UsersDB().deleteAll();
    print("deleted rows: $rows");
    refreshInterface();
  }

}