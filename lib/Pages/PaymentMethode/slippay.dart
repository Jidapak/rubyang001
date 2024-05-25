import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/PaymentMethode/slipmoney.dart';
import 'package:rub_yang/Pages/PaymentMethode/sliptranformer.dart';
import 'package:rub_yang/facview/formtofactory.dart';
import 'package:rub_yang/storeview/homestore.dart';

class ListItem {
  final String title;
  final String details2;
  ListItem({required this.title, required this.details2});
}
class SlipPayment extends StatelessWidget {
  //  final String selectedStoreName;
  // final num priceSheets; // Declare priceSheets as a list
  // SlipPayment({required this.priceSheets, required this.selectedStoreName});
  final List<ListItem> entries = [
    ListItem(
      title: 'ใบเสร็จเงินสด',
      details2: 'ใบเสร็จเงินสด',
    ),
    ListItem(
      title: 'ใบเสร็จการโอน',
      details2: 'ใบเสร็จการโอน',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // print('priceSheets: $priceSheets');
    // print('selectedStoreName: $selectedStoreName');
    return Scaffold(
      appBar: AppBar(
        title: const 
        Text('ร้านรับซื้อ โรงงานและการยาง',
        style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.brown,
            height: 60,
            child: Center(
              child: Text(
                'ใบเสร็จการจ่ายเงินให้ชาวสวน',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(entries[index].title),
                    onTap: () {
                      if(index == 0){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Slipmoney(
                          ),
                        ),
                      );
                      } else if (index == 1){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Sliptranformation(
                          ),
                        ),
                       );
                      }
                      //    else if (index == 5){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>OrderCust(
                      //     // priceSheets: [priceSheets],
                      //     // selectedStoreName: selectedStoreName,
                      //     //  priceSheets: selectedPrice,
                      //   ),
                      //   ),
                      //  );
                      // }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}