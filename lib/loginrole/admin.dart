import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/%E0%B9%89listreport.dart';
import 'package:rub_yang/Pages/farmerInfor.dart';
import 'package:rub_yang/Pages/farmerevent.dart';
import 'package:rub_yang/facview/kanyangform.dart';
import 'package:rub_yang/facview/listkanyang.dart';
import 'package:rub_yang/loginrole/login_pagerole.dart';
import 'package:rub_yang/storeview/homestore.dart';
import 'package:rub_yang/storeview/insertvalue.dart';
import 'package:rub_yang/storeview/quallityyang.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}
class _AdminState extends State<Admin> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผู้ใช้งาน : ${FirebaseAuth.instance.currentUser?.email ?? ''}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.brown[500],
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 25,
              color: Colors.brown[500],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white60.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 100,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                 padding: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'images/kanyang.png',
                    width: 100,
                    height: 120,
                  ),
                ),
                Container(
                  width: 290,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          ' ร้านรับยางสุราษฎร์ \n การยางแห่งประเทศไทย',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          ListTab(),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login_Page(),
      ),
    );
  }
}

class ListItem {
  final String title;
  final String details2;
  ListItem({required this.title, required this.details2});
}
class ListTab extends StatelessWidget {
 final List<ListItem> entries = [
ListItem(
      title: 'รายงานข้อมูลชาวสวนสำหรับส่งกยท',
      details2: 'รายงานข้อมูลชาวสวนสำหรับส่งกยท',
    ),
    // ListItem(
    //   title: 'ประวัติย้อนหลังส่งโรงงาน',
    //   details2: 'ประวัติย้อนหลังส่งโรงงานแต่ละรอบ',
    // ),
    ListItem(
      title: 'อัพเดทแคมเปญกยท',
      details2: 'อัพเดทแคมเปญกยท',
    ),
    //  ListItem(
    //   title:  'อัพเดทราคากลาง',
    //   details2: '1.ราคาเปิดกยทแต่ละวัน จะแบ่งเป็น \n1.1.ยางแผ่นดิบ \n1.2 น้ำยางสด ณโรงงาน\n1.3.\n 2.ราคาที่ให้พิเศษ ',
    // ),
    //  ListItem(
    //   title: 'กยท.ใกล้คุณ',
    //   details2: 'การยางแห่งประเทศไทยแต่ละสาขาในจังหวัดสุราษฎร์',
    // ),
  ListItem(
    title: 'คุณภาพยางพาราชาวสวน',
    details2: 'เช็คคุณภาพควรเข้าร่วมการอบรมพัฒนาคุณภาพ?',
  ),
];

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                          builder: (context) =>Farmer_Infor(
                          ),
                        ),
                      );
                    }
                    // else if (index == 1){
                    //     Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>Factory_Infor(
                    //       ),
                    //     ),
                    //    );
                    //   }
                      //   else if (index == 3){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>ListFactory(
                      //     ),
                      //   ),
                      //  );
                      // }
                       else if (index == 2){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Quanlity(
                          ),
                        ),
                       );
                      }else if (index == 1){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>FormKanyang(
                          ),
                        ),
                       );
                      }
                      // else if (index == 2){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>InsertValue(
                      //     ),
                      //   ),
                      //  );
                      // }
                      //  else if (index == 5){
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>Quanlity(),
                      //   ),
                      //  );
                      // }
                  }, 
            ),
          );
        },
      ),
    );
  }
}
