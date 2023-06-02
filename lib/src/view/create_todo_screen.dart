import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/base.dart';
import 'package:to_do_app/src/model/todo.dart';

// ignore: must_be_immutable
class CreateTodoScreen extends StatelessWidget with Base {
  String? title;
  Todo? todo;
  CreateTodoScreen({this.title, this.todo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            if (title == 'Add Todo')
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
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
                    focusedBorder: OutlineInputBorder(
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
                          title: todoC.todoTitle.value,
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
