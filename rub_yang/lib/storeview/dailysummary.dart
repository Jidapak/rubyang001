import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DailySummaryPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> dailySummary;
  final Map<String, double> totalPricesByType;
  final Map<String, double> totalWeightsByType;
  final DateTime selectedDate;

  DailySummaryPage({
    required this.dailySummary,
    required this.totalPricesByType,
    required this.totalWeightsByType,
    required this.selectedDate,
  });

  @override
  State<DailySummaryPage> createState() => _DailySummaryPageState();
}

class _DailySummaryPageState extends State<DailySummaryPage> {
  late CollectionReference _summaryCollection;
  late Future<FirebaseApp> _firebase;

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _summaryCollection = FirebaseFirestore.instance.collection("summarydaily");
  }

  void _saveSummaryToFirestore() async {
    try {
      await _summaryCollection.add({
        'date': widget.selectedDate,
        'dailySummary': widget.dailySummary,
        'totalPricesByType': widget.totalPricesByType,
        'totalWeightsByType': widget.totalWeightsByType,
        'timestamp': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("บันทึกข้อมูลลง Firebase สำเร็จ!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ไม่สามารถบันทึกข้อมูลลง Firebase: $e")),
      );
    }
  }

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    final date = DateFormat('dd/MM/yyyy').format(widget.selectedDate);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'สรุปรายวันสำหรับ $date',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                headers: ['ร้าน', 'ประเภท', 'ยอดขาย', 'น้ำหนัก'],
                data: widget.dailySummary.entries.expand((entry) {
                  return entry.value.entries.map((e) {
                    return [
                      entry.key,
                      e.key,
                      e.value['totalPrice'].toStringAsFixed(2),
                      e.value['weight'].toStringAsFixed(2),
                    ];
                  });
                }).toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'ยอดรวมทุกประเภท:',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                context: context,
                headers: ['ประเภท', 'ยอดขาย', 'น้ำหนัก'],
                data: widget.totalPricesByType.entries.map((entry) {
                  return [
                    entry.key,
                    entry.value.toStringAsFixed(2),
                    widget.totalWeightsByType[entry.key]!.toStringAsFixed(2),
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "สรุปรายวัน",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'สรุปรายวันสำหรับ ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ร้าน',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ประเภท',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ยอดขาย',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'น้ำหนัก',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                for (var storeName in widget.dailySummary.keys)
                  ...widget.dailySummary[storeName]!.entries.map((entry) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(storeName),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(entry.key),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                entry.value['totalPrice'].toStringAsFixed(2)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text(entry.value['weight'].toStringAsFixed(2)),
                          ),
                        ),
                      ],
                    );
                  }),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'ยอดรวมทุกประเภท:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ประเภท',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ยอดขาย',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'น้ำหนัก',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                for (var entry in widget.totalPricesByType.entries)
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.key),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.value.toStringAsFixed(2)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.totalWeightsByType[entry.key]!
                              .toStringAsFixed(2)),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double
                  .infinity, // Set the width to occupy the entire available space
              child: ElevatedButton(
                onPressed: _saveSummaryToFirestore,
                child: Text('บันทึก'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double
                  .infinity, // Set the width to occupy the entire available space
              child: ElevatedButton(
                onPressed: _createPDF,
                child: Text('ดาวน์โหลด PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Summary {
  DateTime selectedDate;
  Map<String, Map<String, dynamic>> dailySummary;
  Map<String, double> totalPricesByType;
  Map<String, double> totalWeightsByType;

  Summary(
    this.selectedDate,
    this.dailySummary,
    this.totalPricesByType,
    this.totalWeightsByType,
  );
}
