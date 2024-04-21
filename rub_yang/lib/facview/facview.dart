import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/formtrade.dart';

class FacView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderRequestModel>(
      builder : (context,orderRequestmodel,child){
      return Scaffold(
        appBar: AppBar(
          title: Text('คำสั่งส่งยาง'),
          titleTextStyle: 
          TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: ListView.builder(
        itemCount: orderRequestmodel.orders.length,
        itemBuilder: (context, index) {
          final order = orderRequestmodel.orders[index];
          return OrderItem(order: order);
        },
      ),
      );
      }
    );
  }
}
class OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  OrderItem({required this.order});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('no: ${order['no']}'),
            subtitle: Text('price: ${order['price']}'),
          ),
          ListTile(
            title: Text('weight: ${order['weight']}'),
            subtitle: Text('date: ${order['date']}'),
          ),
          ListTile(
            title: Text('time: ${order['time']}'),
          ),
        ],
      ),
    );
  }
}
