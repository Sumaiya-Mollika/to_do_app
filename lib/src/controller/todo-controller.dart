import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/config/api_end_point.dart';
import 'package:to_do_app/src/model/todo.dart';
import 'package:to_do_app/src/view/home_screen.dart';
import 'package:to_do_app/src/widgets/custom_snackbar.dart';

class TaskController extends GetxController {
  final todoTitle = RxString('');
  final description = RxString('');
  final isCompleted = RxBool(false);
  final todoList = RxList<Todo>([]);

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  final Dio _dio = Dio();

// Create todo
  Future<void> createTodo() async {
    final mutation = '''
      mutation CreateTodo(\$title: String!, \$completed: Boolean!) {
        createTodo(input: {
          title: \$title
          completed: \$completed
        }) {
          id
          title
          completed
        }
      }
    ''';

    try {
      final response = await _dio.post(
        ApiEndPoint.baseUrl(),
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'query': mutation,
          'variables': {
            'title': todoTitle.value,
            'completed': isCompleted.value,
          },
        },
      );

      if (response.statusCode == 200) {
        customSnackbar(
            title: 'Todo Added',
            textColor: Colors.white,
            color: Colors.green,
            message: '');

        final todos = Todo.fromJson(
            response.data['data']['createTodo'] as Map<String, dynamic>);

        print(todos);
        todoList.insert(0, todos);
        clearData();
        Get.to(HomeScreen());
      } else {
        customSnackbar(
            title: 'Failed to added todo',
            textColor: Colors.white,
            color: Colors.red,
            message: '');
      }
    } catch (error) {
      // Handle errors
      customSnackbar(
          title: 'An Error Occurred',
          textColor: Colors.white,
          color: Colors.red,
          message: error.toString());
    }
  }

// Get todo's
  void fetchTodos() async {
    try {
      final query = '''
      query {
        todos {
          data {
            id
            title
            completed
          }
        }
      }
    ''';

      final response = await Dio().post(
        ApiEndPoint.baseUrl(),
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'query': query},
      );

      final responseData = response.data;
      final todos = responseData['data']['todos']['data']
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<Todo>() as List<Todo>;

      todoList.clear();
      todoList.addAll(todos);
    } catch (error) {
      // Handle errors
      print('Error occurred while fetching todo list: $error');
    }
  }

// Delete todo
  Future<void> deleteTodo(String todoId) async {
    final mutation = '''
    mutation DeleteTodo(\$id: ID!) {
      deleteTodo(id: \$id)
    }
  ''';

    try {
      final response = await _dio.post(
        ApiEndPoint.baseUrl(),
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'query': mutation,
          'variables': {'id': todoId},
        },
      );

      final responseData = response.data;
      final success = responseData['data']['deleteTodo'];

      if (success != null && success) {
        // Deletion successful
        todoList.removeWhere((element) => element.id == todoId);
        customSnackbar(
            title: 'Todo deleted successfully',
            textColor: Colors.white,
            message: '',
            color: Colors.amber);
      } else {
        // Deletion failed
        customSnackbar(
            title: 'Failed delete todo',
            textColor: Colors.white,
            message: '',
            color: Colors.amber);
      }
    } catch (error) {
      // Handle errors
      customSnackbar(
          title: 'Failed delete todo',
          textColor: Colors.white,
          message: error.toString(),
          color: Colors.amber);
    }
  }

// Update todo
  Future<void> updateTodo({
    required String id,
    required String title,
    required bool completed,
  }) async {
    final mutation = '''
    mutation UpdateTodo(\$id: ID!, \$title: String!, \$completed: Boolean!) {
      updateTodo(id: \$id, input: {
        title: \$title
        completed: \$completed
      }) {
        id
        title
        completed
      }
    }
  ''';

    try {
      final response = await _dio.post(
        ApiEndPoint.baseUrl(),
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'query': mutation,
          'variables': {
            'id': id,
            'title': title,
            'completed': completed,
          },
        },
      );

      if (response.statusCode == 200) {
        // Update successful
        final index = todoList.indexWhere((element) => element.id == id);
        if (index != -1) {
          final updatedTodo = Todo(
            id: todoList[index].id,
            title: title,
            completed: completed,
          );
          todoList[index] = updatedTodo;
        }
        customSnackbar(
          title: 'Todo Updated',
          textColor: Colors.white,
          color: Colors.green,
          message: '',
        );
        clearData();
        Get.to(HomeScreen());
      } else {
        customSnackbar(
          title:
              'GraphQL request failed with status code ${response.statusCode}',
          textColor: Colors.white,
          color: Colors.green,
          message: '',
        );
      }
    } catch (error) {
      // Handle any errors
      customSnackbar(
        title: 'Error Occurred $error',
        textColor: Colors.white,
        color: Colors.red,
        message: '',
      );
    }
  }

  clearData() {
    todoTitle.value = '';
    isCompleted.value = false;
  }
}
