import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/%E0%B9%89listreport.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
import 'package:rub_yang/Pages/confirmorder.dart';
import 'package:rub_yang/Pages/farmerInfor.dart';
import 'package:rub_yang/Pages/farmerevent.dart';
import 'package:rub_yang/facview/formtofactory.dart';
// import 'package:rub_yang/facview/listfactory.dart';
import 'package:rub_yang/facview/listkanyang.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
import 'package:rub_yang/storeview/homestore.dart';
import 'package:rub_yang/storeview/insertvalue.dart';
import 'package:rub_yang/storeview/ordercusto.dart';

class ListItem {
  final String title;
  final String details2;
  ListItem({required this.title, required this.details2});
}
class ListTabStore extends StatelessWidget {
   final String selectedStoreName;
  final num priceSheets; // Declare priceSheets as a list
  ListTabStore({required this.priceSheets, required this.selectedStoreName});
  final List<ListItem> entries = [
    ListItem(
      title: 'ร้านรับยาง(ออเดอร์ชาวสวน)',
      details2: 'ร้านรับยาง(ออเดอร์ชาวสวน)',
    ),
    ListItem(
      title: 'กรอกข้อมูลที่ส่งโรงงาน',
      details2: 'หลังส่งโรงงานแต่ละรอบ',
    ),
    //  ListItem(
    //   title: 'รายการที่กำลังดำเนินการส่งโรงงาน',
    //   details2: 'รายการที่กำลังดำเนินการส่งโรงงาน',
    // ),
    ListItem(
      title: 'ราคาเปิด',
      details2: '1.ราคาเปิดกยทแต่ละวัน จะแบ่งเป็น \n1.1.ยางแผ่นดิบ \n1.2 น้ำยางสด ณโรงงาน\n1.3.Rss3 \n 2.ราคาที่ให้พิเศษ ',
    ),
    ListItem(
      title: 'คุณภาพยางพาราชาวสวน',
      details2: 'เช็คคุณภาพควรเข้าร่วมการอบรมพัฒนาคุณภาพ?',
    ),
     ListItem(
      title: 'รายงานที่สามารถดึงpdf',
      details2: 'รายงานpdf',
    ),
      ListItem(
      title: 'ประวัติย้อนหลังส่งโรงงาน',
      details2: 'ประวัติย้อนหลังส่งโรงงานแต่ละรอบ',
    ),
     ListItem(
      title: 'กยท.ใกล้คุณ',
      details2: 'การยางแห่งประเทศไทยแต่ละสาขาในจังหวัดสุราษฎร์',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    print('priceSheets: $priceSheets');
    print('selectedStoreName: $selectedStoreName');
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
                'ร้านรับซื้อยาง',
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
                          builder: (context) => HomeStore(
                            priceSheets: priceSheets,
                          selectedStoreName: selectedStoreName,
                          ),
                        ),
                      );
                      } else if (index == 1){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>FormFactory(
                          ),
                        ),
                       );
                      }
                      else if (index == 2){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InsertValue(
                          ),
                        ),
                       );
                      }
                      else if (index == 4){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListReport(
                          ),
                        ),
                       );
                      }
                         else if (index == 5){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>ListKanyang(
                          ),
                        ),
                       );
                      }
                        else if (index == 6){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Factory_Infor(
                          ),
                        ),
                       );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 60,
            color: Colors.brown,
            child: Center(
            child: Text(
              'ข้อมูลเพื่อโรงงานและการยาง',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ), 
        ],
      ),
    );
  }
}