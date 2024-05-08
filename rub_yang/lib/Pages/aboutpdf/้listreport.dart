import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport2.dart';
import 'package:rub_yang/Pages/showprofile.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
import 'package:rub_yang/storeview/insertprice.dart';
import 'package:rub_yang/storeview/storedetail_Form.dart';

class ListReport extends StatelessWidget {
  final List<String> entries = ['A', 'B', 'C', 'D','E'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'รายการที่สามารถดึงรายงานได้',
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
            List<String> textList = [
              'ประวัติชาวสวน',
              'ประวัติชาวสวนที่จะเข้าร่วมโครงการปลูกใหม่',
              'รายงานราคาแต่ละร้าน',
              'รายงานราคากลาง',
              'ข้อมูลที่ร้านส่งโรงงาน',
            ];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeReport(
                        ),
                      ),
                    );
                    break;
                  case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeReport2(
                        ),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsertPrice(),
                      ),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Form_Store(),
                      ),
                    );
                    case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => showprofile(),
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
