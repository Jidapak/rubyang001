import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Factory_Infor extends StatefulWidget {
  @override
  _Factory_InforState createState() => _Factory_InforState();
}

class _Factory_InforState extends State<Factory_Infor> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการร้านรับยางส่งโรงงาน',
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("factorydata").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || _user == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Filter the documents based on the user's email
          var filteredDocs = snapshot.data!.docs.where((document) {
            if (_user!.email == 'lekin@gmail.com') {
              return document["namerubyang"] == 'เล็กอิน';
            } else if (_user!.email == 'konong@gmail.com') {
              return document["namerubyang"] == 'โกโหน่ง';
            }
            return false; // Return false for other cases
          }).toList();

          return ListView(
            children: filteredDocs.map((document) {
              DateTime dateTime = DateTime.now();
              String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow("ร้านรับซื้อ", document["namerubyang"]),
                        _buildInfoRow("โรงงาน", document["namefactory"]),
                        _buildInfoRow("คุณภาพยางพารา", "${document["quanlityyang"]} เปอร์เซนต์"),
                        _buildInfoRow("จำนวนรวม", "${document["totalquantity"]} กิโลกรัม"),
                        _buildInfoRow("ยอดเงินที่ได้รับ", "${document["totalpay"]} บาท"),
                        _buildInfoRow("รูปแบบยางพารา", document["_radioValue12"] ?? "ไม่ระบุ"),
                        _buildInfoRow("รอบวันที่", formattedDate),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Factory_Infor extends StatefulWidget {
//   @override
//   _Factory_InforState createState() => _Factory_InforState();
// }

// class _Factory_InforState extends State<Factory_Infor> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'รายการร้านรับยางส่งโรงงาน',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: StreamBuilder(
//         stream:
//             FirebaseFirestore.instance.collection("factorydata").snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((document) {
//               DateTime dateTime = DateTime.now();
//               String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 16.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.brown[800],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     title: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text(
//                               "ร้านรับซื้อ${document["namerubyang"]}ส่งโรงงาน",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             "ชื่อร้านรับซื้อ : ${document["namerubyang"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "ชื่อโรงงาน : ${document["namefactory"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "คุณภาพยางพารา: ${document["quanlityyang"]} เปอร์เซนต์",  
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                           " จำนวนรวม ${document["totalquantity"]} กิโลกรัม", 
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "ยอดเงินที่ได้รับ: ${document["totalpay"]} บาท",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "รูปแบบยางพารา: ${document["_radioValue12"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "รอบวันที่: $formattedDate",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
