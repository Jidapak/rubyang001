import 'package:flutter/material.dart';

class NotiPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แจ้งเตือน',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.brown,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                'เลขคำสั่งซื้อ 1001 สมาชิก 10001',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text('โอนเงินยอด 2500 บาทเรียบร้อยแล้ว'),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                'เลขคำสั่งซื้อ 1002 สมาชิก 10002',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text('โอนเงินยอด 5000 บาทเรียบร้อยแล้ว'),
            ),
          ),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                'เลขคำสั่งซื้อ 1002 สมาชิก 10002',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text('ยางพาราของท่านใกล้ครบกำหนดปลูกยางใหม่แทนยางเก่าในอีก11เดือน'),
            ),
          ),
        ],
      ),
    );
  }
}
