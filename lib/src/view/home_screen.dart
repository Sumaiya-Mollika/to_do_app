import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/view/create_todo_screen.dart';


class HomeScreen extends StatelessWidget with Base{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>Get.to(CreateTodoScreen()),
          ),
        ],
        
     
        ),

          body: Container()
    );
  }
}