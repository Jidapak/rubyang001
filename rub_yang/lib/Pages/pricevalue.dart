import 'package:flutter/material.dart';

class PriceValue extends StatefulWidget {
  @override
  _PriceValueState createState() => _PriceValueState();
}
class _PriceValueState extends State<PriceValue> {
  double currentPrice = 0.0;
  void updatePrice(double newValue) {
    setState(() {
      currentPrice = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ราคาเปิด'),
        titleTextStyle: 
         TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        actions: [
          IconButton(
            onPressed: () {
              double newPrice = 40.00;
              updatePrice(newPrice);
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ราคาประจำวัน:',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              '\$${currentPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double newPrice = 40.00;
                updatePrice(newPrice);
              },
              child: Text('อัปเดตราคาประจำวัน'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(),
                      title: Text('ราคาวันที่ ${index + 1} :\   __'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
