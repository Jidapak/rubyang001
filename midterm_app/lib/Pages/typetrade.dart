import 'package:flutter/material.dart';
import 'package:midterm_app/Pages/list_form.dart';

class type_trade extends StatelessWidget {
  final List<String> entries = ['A', 'B'];

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'ประเภทการซื้อขาย',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => List_form(), 
            ),
          );
        },
         child: Padding(
          padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0, 
          mainAxisSpacing: 16.0,
          children: List.generate(2, (index) {
            List<String> textList = ['ซื้อขายทันที', 'ซื้อขายล่วงหน้า'];
            return Container(
              height: 100.0,
              color: Colors.white70,
              child: Center(
                child: Text(
                  textList[index], 
                  style: TextStyle(
                    fontSize: 18.0, 
                  ),
                ),
              ),
            );
          }),
          ),
        ),
      ),
    );
  }
}
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}
