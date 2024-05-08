import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class reportt2 extends StatefulWidget {
  DocumentSnapshot docid;
  reportt2({required this.docid});
  @override
  State<reportt2> createState() => _reportt2State(docid: docid);
}
class _reportt2State extends State<reportt2> {
  DocumentSnapshot docid;
  _reportt2State({required this.docid});
  final pdf = pw.Document();
  var namefarmer;
  var lastnfarmer;
  var nationality;
  // var telnum;
  var _radioValue12;
  var _radioValue11;
  var areafarm;
  var agetree;
  var quantitytree;
  var selectedCity;
  var location;
  var selectedCountry;
  var selectedState;
  var marks;
  void initState() {
    setState(() {
      namefarmer = widget.docid.get('namefarmer');
      lastnfarmer = widget.docid.get('lastnfarmer');
      nationality = widget.docid.get('nationality');
      // telnum = widget.docid.get('telnum');
      _radioValue12= widget.docid.get('_radioValue12');
      _radioValue11 = widget.docid.get('_radioValue11');
     areafarm = widget.docid.get('areafarm');
      agetree = widget.docid.get('agetree');
      quantitytree= widget.docid.get('quantitytree');
      selectedCity = widget.docid.get('selectedCity');
      location = widget.docid.get('location');
      selectedCountry= widget.docid.get('selectedCountry');
      selectedState = widget.docid.get('selectedState');
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
                    namefarmer,
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
                     lastnfarmer,
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
                    'สัญชาติ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    nationality,
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
                    'ที่อยู่ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    location,
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
                    selectedCity,
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
                    selectedState,
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
                    'ประเทศ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    selectedCountry,
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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'สนใจเข้าร่วมโครงการ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    _radioValue11,
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
                    'เป็นเจ้าของสวนใช่หรือไม่ : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    _radioValue11,
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
                    'พื้นที่สวนยางพารา : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    areafarm,
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
                    'อายุสวนยางพารา : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    agetree,
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
                    'จำนวนต้นยางพารา: ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  pw.Text(
                    quantitytree,
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
