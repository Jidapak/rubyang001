import 'package:flutter/material.dart';

class FarmerEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการชาวสวนเข้าร่วมโครงการปลูกใหม่แทนเก่า',
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
                'เลขที่ส่งโรงงาน :121 \n ร้านเล็ก ตาขุน(20010)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              subtitle: Text('ส่งโรงงานศรีตรัง \n ยอดรวม 100,000บ. \n น้ำหนัก 2ตัน \n ยางพาราชนิดน้ำ'),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                'เลขที่ส่งโรงงาน :122 \n ร้านโกโหน่ง เวียงสระ(20020)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
               subtitle: Text('ส่งโรงงานรับเบอร์ \n ยอดรวม 200,000บ. \n น้ำหนัก 5ตัน \n ยางพาราชนิดก้อน'),
            ),
          ),
        ],
      ),
    );
  }
}
