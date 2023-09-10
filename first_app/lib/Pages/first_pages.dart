import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('First Page'),
        actions: [
          IconButton(onPressed:(){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hello ...'),
                ),
            );
          }, 
          icon: Icon(Icons.add_alert), 
          ),
          IconButton(onPressed:(){
            Navigator.pushNamed(context, '/second');
          }, 
          icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
      body: Center(
        child: Image.network ('https://i.pinimg.com/564x/57/52/01/5752016f1311cf6624af3da7266cb2db.jpg'
        ),
      ),
    );
  } 
}