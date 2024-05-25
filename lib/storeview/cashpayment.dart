import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CashPaymentPage extends StatelessWidget {
  final String email;
  final String orderId;
  final num totalPrice;
  final String Type;
  final String selectedStoreName;
  
  CashPaymentPage({
    required this.email,
    required this.orderId,
    required this.totalPrice,
    required this.Type,
    required this.selectedStoreName
  });
  
  @override
  Widget build(BuildContext context) {
    bool _isTransferring = false;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชำระโดยเงินสด',
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("farmerprofile").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          var farmerprofile = snapshot.data!.docs.first;
          var accountno = farmerprofile['accountno'];
          var bankname = farmerprofile['bankname'];
          var accountname = farmerprofile['accountname'];
          
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'รายการจ่ายเงินหน้าร้าน',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'อีเมล์ลูกค้า : ${email}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'ร้านรับซื้อ: ${selectedStoreName}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'เลขคำสั่งขาย : ${orderId}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ชนิดยาง : ${Type}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ยอดที่จ่าย : ${totalPrice.toStringAsFixed(2)} บาท',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isTransferring ? null : () {
                        _transferMoney(context, farmerprofile);
                        FirebaseFirestore.instance.collection("orderrequet").doc(orderId).update({
                          "status": "จ่ายเงินสดให้ชาวสวน"
                        }).then((value) {
                          // Handle success
                        }).catchError((error) {
                          // Handle error
                        });
                      },
                      child: Text(
                        'ยืนยันการจ่ายเงิน',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        _printDocument(farmerprofile);
                      },
                      icon: Icon(
                        Icons.download,
                        color: Colors.brown,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Divider()
              ],
            ),
          );
        }
      ),
    );
  }

  void _printDocument(DocumentSnapshot document) async {
    // Get the current date and time
    final now = DateTime.now();
    final formattedDate = '${now.day}.${now.month}.${now.year}_${now.hour}.${now.minute}.${now.second}';
    final pdfFileName = 'slipmoney_$formattedDate.pdf'; // Include ".pdf" extension directly
    Printing.layoutPdf(
      onLayout: (format) async => await _generatePdf(document),
      name: pdfFileName, // Specify the file name here
    );
  }

  Future<Uint8List> _generatePdf(DocumentSnapshot farmerData) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.sarabunRegular();
    final Uint8List logoImageBytes = (await rootBundle.load("icons/logorubyangsurrat.png")).buffer.asUint8List();
    final logoImage = pw.MemoryImage(logoImageBytes);
    
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      decoration: pw.BoxDecoration(
                        image: pw.DecorationImage(
                          image: logoImage,
                          fit: pw.BoxFit.contain,
                        ),
                      ),
                    ),
                    pw.Text(
                      'ใบเสร็จการจ่ายเงินสด',
                      style: pw.TextStyle(font: font, fontSize: 24),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'อีเมล์ลูกค้า: ${email}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'ร้านรับซื้อ: ${selectedStoreName}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'เลขคำสั่งขาย: ${orderId}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'ชนิดยาง: ${Type}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'ธนาคาร: ${farmerData['bankname']}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'เลขบัญชี: ${farmerData['accountno']}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'ชื่อบัญชี: ${farmerData['accountname']}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'ยอดที่จ่าย: ${totalPrice.toStringAsFixed(2)} บาท',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'ขอบคุณที่ใช้บริการ',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
            ],
          );
        }
      ),
    );

    return pdf.save();
  }

  void _transferMoney(BuildContext context, DocumentSnapshot farmerData) {
    bool _isTransferring = true;
    
    // Simulate money transfer
    Future.delayed(Duration(seconds: 2), () async {
      // Save order details to Firestore
      try {
        final ref = FirebaseFirestore.instance.collection('printpayment').doc(orderId);
        await ref.set({
          'orderId': orderId,
          'email': email,
          'selectedStoreName': selectedStoreName,
          'type': Type,
          'totalPrice': totalPrice,
          'paymentMethod': 'จ่ายเงินสด',
          // 'bankname': farmerData['bankname'],
          // 'accountno': farmerData['accountno'],
          // 'accountname': farmerData['accountname'],
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Order details saved to Firestore successfully');
      } catch (e) {
        print('Error saving order details to Firestore: $e');
      }

      _isTransferring = false;

      // Show transfer status dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('การโอนเงินสำเร็จ'),
            content: Text('โอนเงินไปยังบัญชีเรียบร้อยแล้ว'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    });
  }
}
