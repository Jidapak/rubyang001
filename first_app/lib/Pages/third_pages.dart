import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget{
   final List<String> imagePaths=[
  'images/babyPolar.png',
  'images/Poling.png',
    'images/Maru.png',
    'images/Sushi.png',
    'images/Polar.png',
    'images/Fatmuji.png',
    'images/Poli.png',
    'images/Tonhom.png',
    'images/Yumi.png',
     'images/Muji.png',
   ];
   final List<String> entries = ['A','B','C','D','E','F','G','H','I','J'];
  final List<int> colorCodes =[500,300,500,300,500,300,500,300,500,300,500,300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Third Page'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, 'Flutter Demo');
            },
           icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
       body: ListView.separated(
         padding:const EdgeInsets.all(10.0),
          itemBuilder: (context, index ){
          return Container(
          color: Colors.green[colorCodes[index]],
          child : Image.asset(
              imagePaths[index],
              width: 150.0, // Set the desired width for each image
              height: 150.0,
          ),
          );
          },    
        itemCount: imagePaths.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(); // Add a separator between images
        },
        ),
      );
  } 
}