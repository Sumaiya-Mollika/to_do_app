import 'package:flutter/material.dart';
import 'package:to_do_app/src/config/base.dart';

class CreateTodoScreen extends StatelessWidget with Base{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Column(
          children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        

           onChanged:taskC.title ,     ),
              
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){}, child: Text('Add'),style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Colors.purple)
    )
  )
))
          ],
        
      
        ),
      ),
    );
  }
}