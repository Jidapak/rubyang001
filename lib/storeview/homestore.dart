import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/PaymentMethode/slippay.dart';
import 'package:rub_yang/Pages/listorderreq.dart';
import 'package:rub_yang/Pages/showprofile.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
import 'package:rub_yang/storeview/insertprice.dart';
import 'package:rub_yang/storeview/ordercusto.dart';
import 'package:rub_yang/storeview/pricestore.dart';
import 'package:rub_yang/storeview/storedetail_Form.dart';
import 'package:rub_yang/storeview/totalorderdaily.dart';

class HomeStore extends StatelessWidget {
  final String selectedStoreName;
  final num priceSheets; // Declare priceSheets as a list
  HomeStore({required this.priceSheets, required this.selectedStoreName});
  final List<String> entries = ['จัดการ \n คำสั่งขาย', 'สถานะการ\nซื้อขายยาง', 'อัพเดต\n ราคารายวัน', 'ยอดรวมการ\nรับซื้อวันนี้','รายละเอียด\n การจ่ายเงิน'];
  final List<IconData> icons = [Icons.list_alt, Icons.signal_cellular_alt, Icons.border_color_sharp, Icons.price_change_sharp, Icons.document_scanner_rounded];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'ร้านรับยาง(ออเดอร์ชาวสวน)',
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
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderCust(
                          //  priceSheets: selectedPrice,
                        ),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListOrderReq(
                          //  priceSheets: selectedPrice,
                        ),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PriceStore(),
                        // builder: (context) => InsertPrice(),
                      ),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TotlalOrderReq(),
                      ),
                    );
                    break;
                       case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>SlipPayment(),
                      ),
                    );
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 50.0,
                        color: Colors.brown[800], // Set icon color as needed
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        entries[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
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
