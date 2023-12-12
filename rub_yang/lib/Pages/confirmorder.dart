import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/list_trade.dart';

class ConfirmO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderRequestModel>(
      builder : (context,orderRequestmodel,child){
      return Scaffold(
        appBar: AppBar(
          title: Text('ยืนยันคำสั่งซื้อ',
           style: TextStyle(
           fontSize: 20.0,
           fontWeight: FontWeight.bold,
           color: Colors.brown,
            ),
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
            title: Text('เลขที่คำสั่งซื้้อ: ${order['no']}'),
            subtitle: Text('ราคา: ${order['price']} บาท'),
          ),
          ListTile(
            title: Text('น้ำหนัก: ${order['weight']} กิโลกรัม'),
            subtitle: Text('วันที่จะมาส่ง: ${order['date']}'),
          ),
          ListTile(
            title: Text('เวลาที่จะมาส่ง: ${order['time']}'),
          ),
          ListTile(
            title: Text('รูปแบบยาง: ${order['radioTrade1']}'),
            subtitle: Text('รูปแบบการซื้อขาย: ${order['radioTrade2']}'),
          ),
        ],
      ),
    );
  }
}
