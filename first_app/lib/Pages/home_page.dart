import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  title:Text('Home'),
),
body : GridView.count(
  crossAxisCount: 2,
  children: List.generate(6, (index){
    return InkWell(
      onTap:() {
        Navigator.pushNamed(context,'/${index + 1}');
      },
      child: Container(
        margin:EdgeInsets.all(20.0) ,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(50.0)
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Icon(Icons.home),
            Text('Go to Page ${index+1}'),
          ],
          ),
         ),
    );
     }),
    ),
   );
  }
}