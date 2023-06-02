import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/model/todo.dart';

// ignore: must_be_immutable
class CreateUpdateTodoScreen extends StatelessWidget with Base {
  String? title;
  Todo? todo;
  CreateUpdateTodoScreen({this.title, this.todo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 107, 247),
        title: Text(
          title!,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            if (title == 'Add Todo')
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: todoC.todoTitle,
              ),
            if (title == 'Update Todo')
              Obx(
                () => TextFormField(
                  initialValue: todo!.title,
                  decoration: InputDecoration(
                    prefixIcon: Checkbox(
                      value: todoC.isCompleted.value,
                      onChanged: (value) {
                        todoC.isCompleted.toggle();
                      },
                    ),
                    labelText: 'Title',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: todoC.todoTitle,
                ),
              ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  title == 'Update Todo'
                      ? todoC.updateTodo(
                          id: todo!.id,
                          title: todoC.todoTitle.value != ''
                              ? todoC.todoTitle.value
                              : todo!.title,
                          completed: todoC.isCompleted.value)
                      : todoC.createTodo();
                },
                child: Text(title == 'Update Todo' ? 'Update' : 'Add'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.purple)))))
          ],
        ),
      ),
    );
  }
}
