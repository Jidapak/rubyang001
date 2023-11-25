import 'package:flutter/material.dart';
import 'package:rub_yang/storeview/notiorder.dart';

class HomeStore extends StatelessWidget {
  final List<String> entries = ['A', 'B','C','D'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'ร้านรับซื้อ',
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
              builder: (context) => NotiOrder(),
            ),
          );
        },
         child: Padding(
          padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0, 
          mainAxisSpacing: 16.0,
          children: List.generate(4, (index) {
            List<String> textList = ['รายการแจ้งเตือน \n จากลูกค้า','คิดราคาเมื่อเช็ค\n เปอร์เซนต์แล้ว', 'คำสั่งส่งโรงงาน','รายการย้อนหลัง'];
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
