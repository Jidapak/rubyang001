import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransferPaymentPage extends StatefulWidget {
  final String email;
  final String orderId;
  final num totalPrice;
  final String Type;
  final String selectedStoreName;
  TransferPaymentPage({
    required this.email,
    required this.orderId,
    required this.totalPrice,
    required this.Type,
    required this.selectedStoreName
  });
  @override
  _TransferPaymentPageState createState() => _TransferPaymentPageState();
}

class _TransferPaymentPageState extends State<TransferPaymentPage> {
  String? _selectedPaymentMethod;
  bool _isTransferring = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชำระโดยการโอน',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("farmerprofile").snapshots(),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      color: Colors.brown[600],
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'โอนเงินไปยังบัญชีธนาคาร',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ร้านที่เลือก : ${widget.selectedStoreName}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'อีเมล์ลูกค้า : ${widget.email}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'เลขคำสั่งขาย : ${widget.orderId}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'ชนิดยาง : ${widget.Type}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'ยอดที่ต้องจ่าย : ${widget.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20),
                            Divider(),
                            Text(
                              'ธนาคาร: $bankname',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'เลขบัญชี: $accountno',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'ชื่อบัญชี: $accountname',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _isTransferring
                                    ? null
                                    : () {
                                        _transferMoney(context, farmerprofile);
                                        FirebaseFirestore.instance
                                            .collection("orderrequet")
                                            .doc(widget.orderId)
                                            .update({
                                          "status": "โอนเงินให้ชาวสวน"
                                        }).then((value) {
                                          // Successfully updated status
                                        }).catchError((error) {
                                          // Error updating status
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('เกิดข้อผิดพลาด'),
                                                content: Text(
                                                    'ไม่สามารถอัปเดตสถานะคำสั่งซื้อได้: $error'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('ตกลง'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                      },
                                child: Text(
                                  'ยืนยันการโอนเงิน',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ดาวน์โหลดใบเสร็จ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.print_outlined),
                                  color: Colors.white,
                                  iconSize: 35,
                                  onPressed: () {
                                    _printDocument(farmerprofile);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildText(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  void _printDocument(DocumentSnapshot document) async {
    // Get the current date and time
    final now = DateTime.now();
    final formattedDate = '${now.day}.${now.month}.${now.year}_${now.hour}.${now.minute}.${now.second}';
    final pdfFileName = 'sliptranf_$formattedDate.pdf'; 
    Printing.layoutPdf(
      onLayout: (format) async => await _generatePdf(document),
      name: pdfFileName, 
    );
  }

  Future<Uint8List> _generatePdf(DocumentSnapshot farmerData) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.sarabunRegular();

    final Uint8List logoImageBytes =
        (await rootBundle.load("icons/logorubyangsurrat.png"))
            .buffer
            .asUint8List();
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
                      'ใบเสร็จการโอนจ่าย',
                      style: pw.TextStyle(font: font, fontSize: 24),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'อีเมล์ลูกค้า: ${widget.email}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'ร้านรับซื้อ: ${widget.selectedStoreName}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'เลขคำสั่งขาย: ${widget.orderId}',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.Text(
                'ชนิดยาง : ${widget.Type}',
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
                'ยอดที่จ่าย: ${widget.totalPrice.toStringAsFixed(2)} บาท',
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
        },
      ),
    );

    return pdf.save();
  }

  void _transferMoney(BuildContext context, DocumentSnapshot farmerData) {
    setState(() {
      _isTransferring = true;
    });

    // Simulate money transfer
    Future.delayed(Duration(seconds: 2), () async {
      // Save order details to Firestore
      try {
        final ref = FirebaseFirestore.instance.collection('printslip').doc(widget.orderId);
        await ref.set({
          'orderId': widget.orderId,
          'email': widget.email,
          'selectedStoreName': widget.selectedStoreName,
          'type': widget.Type,
          'totalPrice': widget.totalPrice,
          'bankname': farmerData['bankname'],
          'accountno': farmerData['accountno'],
          'accountname': farmerData['accountname'],
          'paymentMethod': 'โอนเงิน',
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Order details saved to Firestore successfully');
      } catch (e) {
        print('Error saving order details to Firestore: $e');
      }

      setState(() {
        _isTransferring = false;
      });

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
