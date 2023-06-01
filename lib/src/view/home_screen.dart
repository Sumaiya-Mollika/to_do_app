import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/view/create_todo_screen.dart';


class HomeScreen extends StatelessWidget with Base{

  @override
  Widget build(BuildContext context) {
    taskC.fetchTodos();
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

          body: Obx
          (
           ()=> ListView.builder(
            shrinkWrap: true,
            primary: false,
              itemCount: taskC.todoList.length,
              itemBuilder: (context,index){
                 final item= taskC.todoList[index];
                return
             
               Padding(
                 padding: const EdgeInsets.only(bottom: 10),
                 child: ListTile(
                  dense: true,
                  tileColor: Color.fromARGB(255, 243, 217, 248),
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  leading: Icon(item.completed==true?Icons.check:null,color: Colors.green,),
                  title:Text(item.title) ,
                  subtitle: Text(item.completed==true?'Complete':'Incomplate'),
                  trailing: IconButton(onPressed: (){
                    taskC.deleteTodo(item.id);
                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                             ),
               );},
            ),
          )
    );
  }
}