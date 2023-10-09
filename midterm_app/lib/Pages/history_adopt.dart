import 'package:flutter/material.dart';
import 'package:midterm_app/Pages/list_form.dart';
import 'package:provider/provider.dart';

class history extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderRequestmodel = Provider.of<OrderRequestModel>(context);
    print(orderRequestmodel.orders);
    return Scaffold(
      appBar: AppBar(
        title: Text('ยืนยันคำสั่งซื้อ'),
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
