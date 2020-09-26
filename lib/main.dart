import 'package:flutter/material.dart';
import 'package:my_sqlite/users_interface.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Center(
          child: UsersInterface(),
        ),
      )
    );
  }

}

