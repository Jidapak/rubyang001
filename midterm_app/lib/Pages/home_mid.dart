import 'package:flutter/material.dart';
class HomePageMid extends StatelessWidget {
  late Map<int, Map<String, dynamic>> itemData = {
  0: {
    "icon": Icons.shopping_cart_checkout,
    "text": 'คำสั่งรับยาง',
  },
  1: {
    "icon": Icons.document_scanner,
    "text": 'รายการ\nย้อนหลัง',
  },
  2: {
    "icon": Icons.menu_book,
    "text": 'ข่าวสาร&\nความรู้',
  },
  3: {
    "icon": Icons.price_change,
    "text": 'ราคาเปิด',
  },
  4: {
    "icon": Icons.location_city,
    "text": 'ตำแหน่งที่ตั้ง',
  },
  5: {
    "icon": Icons.family_restroom_outlined,
    "text": 'กลุ่มสมาชิก',
  },
}!;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(left: 4.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Rub_Yang',
                        style: TextStyle(
                          fontSize: 20.0,
                           letterSpacing: 2.0,
                          color:Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                  IconButton(
                  onPressed: (){
                   ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                   content: Text('แจ้งเตือน'),
                    ),
                   );
                 }, 
                 icon: Icon(
                  Icons.add_alert,
                  color: Colors.black,
                  size: 25,
                   ),
                  ),
               ],
              ),
            ),
          ),
        ),
      ),
      body: GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      children: List.generate(itemData.length, (index) {
      final IconData icon = itemData[index]?["icon"] ?? Icons.error;
      final String text = itemData[index]?["text"] ?? "Error Text";
     return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/${index + 1}');
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30.0,
              color: Colors.black54,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }),
),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Container(
          height: kBottomNavigationBarHeight-30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Setting'),
                    ),
                  );
                },
                icon: Icon(Icons.settings),
                color: Colors.black,
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
                color: Colors.black,
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.qr_code),
                color: Colors.black,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}