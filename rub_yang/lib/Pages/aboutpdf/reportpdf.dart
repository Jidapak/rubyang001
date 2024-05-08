import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class reportt extends StatefulWidget {
  DocumentSnapshot docid;
  reportt({required this.docid});
  @override
  State<reportt> createState() => _reporttState(docid: docid);
}

class _reporttState extends State<reportt> {
  DocumentSnapshot docid;
  _reporttState({required this.docid});
  final pdf = pw.Document();
  var NameF;
  var NameL;
  var Address;
  var Subdistrict;
  var District;
  var province;
  var Teleph;
  var accountno;
  var bankname;
  var accountname;
  var marks;
  void initState() {
    setState(() {
      NameF = widget.docid.get('NameF');
      NameL = widget.docid.get('NameL');
      Address = widget.docid.get('Address');
      Subdistrict = widget.docid.get('Subdistrict');
      District = widget.docid.get('District');
      province = widget.docid.get('province');
      Teleph = widget.docid.get('Teleph');
      accountno = widget.docid.get('accountno');
      bankname = widget.docid.get('bankname');
      accountname = widget.docid.get('accountname');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'ตัวอย่างรายงาน ',
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
                    'ชื่อจริง : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    NameF,
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
                    'นามสกุล : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    NameL,
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
                    'ที่อยู่ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    Address,
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
                    'ตำบล : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    Subdistrict,
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
                    'อำเภอ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    District,
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
                    'จังหวัด : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    province,
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
                    'โทรศัพท์ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    Teleph,
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
                    'เลขบัญชี : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    accountno,
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
                    'ธนาคาร : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    bankname,
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
                    'ชื่อบัญชี : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    accountname,
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
    return doc.save();
  }
}
