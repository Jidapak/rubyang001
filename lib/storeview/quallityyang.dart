import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Quanlity extends StatefulWidget {
  @override
  _QuanlityState createState() => _QuanlityState();
}

class _QuanlityState extends State<Quanlity> {
  late AsyncSnapshot<QuerySnapshot> _snapshot;
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
          "คุณภาพยาง",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("calculateorders")
            .where('selectedStoreName', isEqualTo: selectedStoreName)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _snapshot = snapshot; // Assigning snapshot to _snapshot
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'อีเมล์ชาวสวน',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เลขคำสั่งขาย',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เปอร์เซนต์DRC',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: snapshot.data!.docs.map<DataRow>((document) {
                return DataRow(cells: [
                  DataCell(Text("${document["email"]}")),
                  DataCell(Text("${document["orderId"]}")),
                  DataCell(Text("${document["DRCpercent"]}")),
                ]);
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _printPdf(context);
        },
        child: Icon(Icons.print),
      ),
    );
  }

  Future<void> _printPdf(BuildContext context) async {
    final pdf = pw.Document();

    final List<List<dynamic>> dataRows = [
      ['อีเมล์ชาวสวน', 'เลขคำสั่งขาย', 'เปอร์เซนต์DRC'],
      for (var doc in _snapshot.data!.docs) [doc["email"], doc["orderId"], doc["DRCpercent"]]
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Table.fromTextArray(
              context: context,
              cellAlignment: pw.Alignment.centerLeft,
              headerAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(fontSize: 10),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              data: dataRows,
            ),
          ];
        },
      ),
    );

    Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
