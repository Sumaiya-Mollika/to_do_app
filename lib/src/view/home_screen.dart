import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/view/create_update_todo_screen.dart';

class HomeScreen extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // todoC.fetchTodos();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 107, 247),
          title: Text(
            'Todos',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Get.to(CreateUpdateTodoScreen(
                title: 'Add Todo',
              )),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: todoC.todoList.length,
              //  reverse: true,
              itemBuilder: (context, index) {
                final item = todoC.todoList[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    selectedTileColor: Colors.grey[300],
                    dense: true,
                    onTap: () {
                      todoC.isCompleted.value = item.completed;
                      Get.to(CreateUpdateTodoScreen(
                        title: 'Update Todo',
                        todo: item,
                      ));
                    },
                    tileColor: Color.fromARGB(255, 243, 217, 248),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    leading: Icon(
                      item.completed ? Icons.check : null,
                      color: Colors.green,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(
                      item.completed ? 'Complete' : 'Incomplate',
                      style: TextStyle(
                          color: item.completed ? Colors.green : Colors.red),
                    ),
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
          ),
        ));
  }
}
