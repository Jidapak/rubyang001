import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Slipmoney extends StatefulWidget {
  @override
  _SlipmoneyState createState() => _SlipmoneyState();
}

class _SlipmoneyState extends State<Slipmoney> {
  String? selectedStoreName;

  @override
  void initState() {
    super.initState();
    determineStoreName();
  }

  void determineStoreName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      if (email == 'lekin@gmail.com') {
        selectedStoreName = 'เล็กอิน';
      } else if (email == 'konong@gmail.com') {
        selectedStoreName = 'โกโหน่ง';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ใบเสร็จเงินสด",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("printpayment")
            .where('selectedStoreName', isEqualTo: selectedStoreName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'อีเมล์ลูกค้า: ${document["email"]}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'เลขคำสั่งขาย: ${document["orderId"]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'ร้านรับซื้อ: ${document["selectedStoreName"]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'ชนิดยาง: ${document["type"]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'วิธีการจ่ายเงิน: ${document["paymentMethod"]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'ยอดที่จ่าย: ${document["totalPrice"]}',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'วันที่ทำรายการ: ${(document["createdAt"] as Timestamp).toDate()}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//   Future<void> _printPdf(BuildContext context) async {
//     final pdf = pw.Document();

//     final List<List<dynamic>> dataRows = [
//       ['อีเมล์ชาวสวน', 'เลขคำสั่งขาย', 'เปอร์เซนต์DRC'],
//       for (var doc in _snapshot.data!.docs) [doc["email"], doc["orderId"], doc["DRCpercent"]]
//     ];

//     pdf.addPage(
//       pw.MultiPage(
//         build: (pw.Context context) {
//           return [
//             pw.Table.fromTextArray(
//               context: context,
//               cellAlignment: pw.Alignment.centerLeft,
//               headerAlignment: pw.Alignment.centerLeft,
//               cellStyle: pw.TextStyle(fontSize: 10),
//               headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               data: dataRows,
//             ),
//           ];
//         },
//       ),
//     );

//     Printing.layoutPdf(
//       onLayout: (format) async => pdf.save(),
//     );
//   }
// }
