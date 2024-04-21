import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/formtrade.dart';

class Spot_F extends StatelessWidget {
  final List<String> entries = ['A', 'B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'ประเภทการซื้อขาย',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Formtrade(), // Replace with the next page you want to navigate to
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
                  textList[index], // Use the text from the list
                  style: TextStyle(
                    fontSize: 18.0, // Customize the style here
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
