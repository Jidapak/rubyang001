import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget{
  final List<String> entries = ['A','B','C','D','E'];
  final List<int> colorCodes =[600, 500,400,300,100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Second Page'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/third');
            },
           icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
      body: ListView.separated(
        padding:const EdgeInsets.all(12.0),
        itemBuilder: (context, index ){
          return Container(
            height: 150.0 ,
            color: Colors.green[colorCodes[index]],
            child: Center(
              child:Text('Item ${entries[index]}'),
               ),
          );
        },
        separatorBuilder:(context, index ) => Divider() ,
        itemCount: entries.length,
        ),
      );
  }
}