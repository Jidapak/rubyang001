import 'dart:typed_data'; // Import the dart:typed_data library
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class Farmer_Infor extends StatefulWidget {
  @override
  _Farmer_InforState createState() => _Farmer_InforState();
}

class _Farmer_InforState extends State<Farmer_Infor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชาวสวนที่จะเข้าร่วมขอทุนกยท',
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.5,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("farmerdata").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText(
                          "ชื่อชาวสวน: ${document["namefarmer"]} ${document["lastnfarmer"]}",
                          16.0,
                        ),
                        _buildText(
                          "สัญชาติ: ${document["nationality"]}",
                          16.0,
                        ),
                        _buildText(
                          "ที่อยู่: ${document["location"]} ${document["selectedCity"]}",
                          16.0,
                        ),
                        _buildText(
                          "จังหวัด: ${document["selectedState"]} ${document["selectedCountry"]}",
                          16.0,
                        ),
                        _buildText(
                          "ขนาดฟาร์ม: ${document["areafarm"]} ไร่",
                          16.0,
                        ),
                        _buildText(
                          "จำนวนต้นยาง: ${document["quantitytree"]} ต้น",
                          16.0,
                        ),
                        _buildText(
                          "จำนวนต้นยางอายุ > 25 ปี: ${document["agetree"]} ต้น",
                          16.0,
                        ),
                        _buildText(
                          "เป็นเจ้าของสวน ?: ${document["_radioValue12"]} ",
                          16.0,
                        ),
                        _buildText(
                          "เข้าร่วมโครงการกยท ?: ${document["_radioValue11"]} ",
                          16.0,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.print_outlined),
                      color: Colors.white,
                      iconSize: 35,
                      onPressed: () {
                        _printDocument(document);
                      },
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
    Printing.layoutPdf(
      onLayout: (format) async => await _generatePdf([document]),
    );
  }

  Future<Uint8List> _generatePdf(List<DocumentSnapshot> farmerData) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.sarabunRegular();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Header(level: 0, child: pw.Text('ชาวสวนที่จะเข้าร่วมขอทุนกยท', style: pw.TextStyle(font: font))),
              pw.ListView.builder(
                itemCount: farmerData.length,
                itemBuilder: (context, index) {
                  final document = farmerData[index];
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                     pw.Text(
                        "ชื่อชาวสวน: ${document["namefarmer"]} ${document["lastnfarmer"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "สัญชาติ: ${document["nationality"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "ที่อยู่: ${document["location"]} ${document["selectedCity"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "จังหวัด: ${document["selectedState"]} ${document["selectedCountry"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "ขนาดฟาร์ม: ${document["areafarm"]} ไร่",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "จำนวนต้นยาง: ${document["quantitytree"]} ต้น",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "จำนวนต้นยางอายุ > 25 ปี: ${document["agetree"]} ต้น",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "เป็นเจ้าของสวน ?: ${document["_radioValue12"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Text(
                        "เข้าร่วมโครงการกยท ?: ${document["_radioValue11"]}",
                        style: pw.TextStyle(font: font),
                      ),
                      pw.Divider(),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}