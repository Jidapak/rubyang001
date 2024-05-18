import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class reportt3 extends StatefulWidget {
  DocumentSnapshot docid;
  reportt3({required this.docid});
  @override
  State<reportt3> createState() => _reportt3State(docid: docid);
}
class _reportt3State extends State<reportt3> {
  DocumentSnapshot docid;
  _reportt3State({required this.docid});
  final pdf = pw.Document();
  var orderId;
  var email;
  var selectedPaymentMethod ;
  var DRCpercent;
  var weightofcup;
  var weightoftotal;
  var totalPrice;
  var timestamp;

  void initState() {
    setState(() {
     orderId = widget.docid.get('orderId');
      email = widget.docid.get('email');
      selectedPaymentMethod = widget.docid.get('selectedPaymentMethod ');
      // telnum = widget.docid.get('telnum');
      DRCpercent= widget.docid.get('DRCpercent');
      weightofcup = widget.docid.get('weightofcup');
     weightoftotal = widget.docid.get('weightoftotal');
      totalPrice = widget.docid.get('totalPrice');
      timestamp= widget.docid.get('timestamp');
     
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'ใบเสร็จจ่ายเงิน ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PdfPreview(
        build: (format) => generateDocument(
          format,
        ),
      ),
    );
  }
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font = await PdfGoogleFonts.notoSansThaiRegular();

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format,
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.SizedBox(
                height: 20,
              ),
              pw.Center(
                child: pw.Text(
                  'รายงาน',
                  style: pw.TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'เลขคำสั่งขาย : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    orderId,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'อีเมล์ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                     email,
                    style: pw.TextStyle(
                      fontSize: 30
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'DRC % : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    DRCpercent,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'น้ำหนักการตวง : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    weightofcup,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'น้ำหนักรวม : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    weightoftotal,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'ยอดเงินที่จ่าย : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    totalPrice,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'เวลาที่จ่าย : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    timestamp,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'โทรศัพท์ : ',
              //       style: pw.TextStyle(
              //         fontSize: 30,
              //       ),
              //     ),
              //     pw.Text(
              //       telnum,
              //       style: pw.TextStyle(
              //         fontSize: 30,
              //       ),
              //     ),
              //   ],
              // ),
                ],
          ));
        },
      ),
    );
    return doc.save();
  }
}
