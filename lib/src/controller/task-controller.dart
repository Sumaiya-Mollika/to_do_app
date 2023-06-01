
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/src/model/todo.dart';
import 'package:to_do_app/src/view/home_screen.dart';
import 'package:to_do_app/src/widgets/custom_snackbar.dart';

class TaskController extends GetxController {
  final todoTitle = RxString('');
  final description = RxString('');
  final isCompleted = RxBool(false);

  final todoList=RxList<Todo>([]);

final url = 'https://graphqlzero.almansi.me/api';

  final Dio _dio = Dio();

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
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'query': mutation,
          'variables': {
            'title': todoTitle.value,
            'completed': isCompleted.value,
          },
        },
      );

      final responseData = response.data;

      if (response.statusCode == 200) {
       customSnackbar(title: 'Todo Added',textColor: Colors.white,color:Colors.green,message: '' );
       todoTitle.value='';
       Get.to(HomeScreen());
        final data = responseData['data'];
        final createTodo = data['createTodo'];
        final id = createTodo['id'];
        final title = createTodo['title'];
        final completed = createTodo['completed'];

      } else {
        print('GraphQL request failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
       customSnackbar(title: 'Error Occured',textColor: Colors.white,color:Colors.red,message: '' );
      print('Error occurred: $error');
    }
  }




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
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {'query': query},
    );

    final responseData = response.data;
    final todos =   responseData['data']['todos']['data']
        .map((json) => Todo.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<Todo>() as List<Todo>;

    
   todoList.clear(); 
   todoList.addAll(todos);



  } catch (error) {
    // Handle any errors
    print('Error occurred: $error');
  }
}

Future<void> deleteTodo(String todoId) async {
  final url = 'https://graphqlzero.almansi.me/api';

  final mutation = '''
    mutation DeleteTodo(\$id: ID!) {
      deleteTodo(id: \$id)
    }
  ''';

  try {
    final response = await _dio.post(
      url,
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
      print('Todo deleted successfully');
    } else {
      // Deletion failed
      print('Failed to delete todo');
    }
  } catch (error) {
    // Handle any errors
    print('Error occurred: $error');
  }
}



}


