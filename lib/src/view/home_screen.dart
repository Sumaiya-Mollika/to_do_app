import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/view/create_todo_screen.dart';

class HomeScreen extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    todoC.fetchTodos();
    return Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(CreateTodoScreen(
                title: 'Add Todo',
              )),
            ),
          ],
        ),
        body: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: todoC.todoList.length,
            itemBuilder: (context, index) {
              final item = todoC.todoList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  dense: true,
                  onTap: () {
                    todoC.isCompleted.value = item.completed;
                    Get.to(CreateTodoScreen(
                      title: 'Update Todo',
                      todo: item,
                    ));
                  },
                  tileColor: Color.fromARGB(255, 243, 217, 248),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  leading: Icon(
                    item.completed == true ? Icons.check : null,
                    color: Colors.green,
                  ),
                  title: Text(item.title),
                  subtitle:
                      Text(item.completed == true ? 'Complete' : 'Incomplate'),
                  trailing: IconButton(
                      onPressed: () {
                        todoC.deleteTodo(item.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
              );
            },
          ),
        ));
  }
}
