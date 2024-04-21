import 'package:flutter/material.dart';

class Orderfactory extends StatelessWidget {
  Orderfactory({Key? key}) : super(key: key);
  List<String> orderno = ["123", "124", "125"];
  List<String> userno = ["10001", "10002", "10003"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ออเดอรส่งโรงงาน',
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
      body: Container(
        child: ListView.builder(
          itemCount: orderno.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, 
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), 
              ),
              child: ListTile(
               contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: CircleAvatar(
                  backgroundImage: 
                      AssetImage('images/order_icon.jpg'), 
                ),
                title: Text(
                  'เลขคำสั่งซื้อ : ${orderno[index]}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'เลขสมาชิก : ${userno[index]}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}