import 'package:flutter/material.dart';

class HomePageR extends StatelessWidget {
  late Map<int, Map<String, dynamic>> itemData = {
  0: {"icon": Icons.shopping_cart_checkout,
    "text": 'ขายยางพารา',
  },
  1: {
    "icon": Icons.document_scanner,
    "text": 'รายการขาย\nยางของคุณ',
  },
  2: {
    "icon": Icons.price_change_rounded,
    "text": 'ราคากลาง \n    วันนี้',
  },
   3: {
    "icon": Icons.list_alt_outlined,
    "text": '  กรอกขอทุน \n   ปลุกใหม่  ',
  },
  //   4: {
  //   "icon": Icons.stairs,
  //   "text": ' สถานะ \n คำสั่งซื้อ',
  // },
  4: {
    "icon": Icons.sell,
    "text": '   ราคา \n แต่ละร้าน',
  },
      5: {
    "icon": Icons.newspaper,
    "text": ' ข่าวสาร\nการยาง',
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
                      'Surat_Rubyang',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   onPressed: () {
                //   Navigator.pushNamed(context, '/notipay');
                //   },
                //   icon: Icon(
                //     Icons.add_alert,
                //     color: Colors.black,
                //     size: 25,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 1; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/M$i.jpg",
                        height: 180,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
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
        ),
      ],
    ),
    bottomNavigationBar: BottomAppBar(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Container(
        height: kBottomNavigationBarHeight - 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                 Navigator.pushNamed(context, '/9');
              },
              icon: Icon(Icons.home),
              color: Colors.brown,
              iconSize: 40,
            ),
          ],
        ),
      ),
    ),
  );
}
}