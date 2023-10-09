import 'package:flutter/material.dart';
import 'package:midterm_app/Pages/typetrade.dart';

class product_type extends StatelessWidget {
    final List<String> entries = ['แบบก้อน','แบบแผ่น', 'แบบน้ำ'];
  final List<String> imagePaths = [
  'images/rub_3.jpg',
  'images/rub_1.jpg',
  'images/rub_2.jpg',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('ประเภทยางพารา'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => type_trade(
                  ),
                ),
              );
            },
            child: Container(
              height: 150.0,
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePaths[index],
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover, 
                  ),
                  Text(
                    '${entries[index]}',
                  style :TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color:Colors.white,
                  fontWeight: FontWeight.bold, 
                  ),
                ),
              ],
            ),
           )
         );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: entries.length,
      ),
    );
  }
}
