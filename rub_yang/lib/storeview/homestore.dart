import 'package:flutter/material.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
import 'package:rub_yang/storeview/insertprice.dart';
import 'package:rub_yang/storeview/storedetail_Form.dart';
class HomeStore extends StatelessWidget {
  final List<String> entries = ['A', 'B', 'C', 'D'];
final String storeName;
  final num dailyPrice;
   HomeStore({
    Key? key,
    required this.storeName,
    required this.dailyPrice,
  }) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: List.generate(4, (index) {
            List<String> textList = [
              'รายการแจ้งเตือน \n จากลูกค้า',
              'รายการโอนเงิน\n ให้ชาวสวน',
              'อัพเดทราคารายวัน',
              'อัพเดทรายละเอียดร้าน'
            ];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmBK(
                           storeName: storeName,
                           dailyPrice: dailyPrice,
                        ),
                      ),
                    );
                    break;
                  case 1:
                    break;
                   case 2: Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsertPrice(),
                      ),
                   );
                    break;
                    case 3: Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Form_Store(),
                      ),
                   );
                  default:
                    break;
                }
              },
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    textList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
