import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DailySummaryPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> dailySummary;
  final Map<String, double> totalPricesByType;
  final Map<String, double> totalWeightsByType;
  final DateTime selectedDate;
  final String userEmail;

  DailySummaryPage({
    required this.dailySummary,
    required this.totalPricesByType,
    required this.totalWeightsByType,
    required this.selectedDate,
    required this.userEmail,
  });

  @override
  State<DailySummaryPage> createState() => _DailySummaryPageState();
}

class _DailySummaryPageState extends State<DailySummaryPage> {
  late CollectionReference _summaryCollection;
  Map<String, Map<String, TextEditingController>> _controllers = {};
  Map<String, Map<String, TextEditingController>> _weightControllers = {};
  late Map<String, TextEditingController> _totalController={};
late Map<String, TextEditingController> _totalWeightController={};
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _summaryCollection = FirebaseFirestore.instance.collection("summarydaily");
    _saveSummaryToFirestore();

    // Initialize controllers
    widget.dailySummary.forEach((storeName, storeData) {
      _controllers[storeName] = {};
      _weightControllers[storeName] = {};
      storeData.forEach((type, data) {
        _controllers[storeName]![type] = TextEditingController(
          text: data['totalPrice'].toStringAsFixed(2),
        );
        _weightControllers[storeName]![type] = TextEditingController( 
          text: data['weight'].toStringAsFixed(2),
        );
      });
    });
  }

  void _saveSummaryToFirestore() async {
      await _summaryCollection.add({
        'date': widget.selectedDate,
        'dailySummary': widget.dailySummary,
        'totalPricesByType': widget.totalPricesByType,
        'totalWeightsByType': widget.totalWeightsByType,
        'timestamp': DateTime.now(),
        'userEmail': widget.userEmail,
      });
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
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold),
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
                style: pw.TextStyle(
                    fontSize: 18, fontWeight: pw.FontWeight.bold),
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

  void _saveEditedData() {
    Map<String, Map<String, dynamic>> updatedSummary = {};

    _controllers.forEach((storeName, storeData) {
      updatedSummary[storeName] = {};
      storeData.forEach((type, controller) {
        double? totalPrice = double.tryParse(controller.text);
        double? weight = double.tryParse(_weightControllers[storeName]![type]!.text); 
        if (totalPrice != null && weight != null) { 
          updatedSummary[storeName]![type] = {
            'totalPrice': totalPrice,
            'weight': weight, 
          };
        }
      });
    });

    setState(() {
      widget.dailySummary.clear();
      widget.dailySummary.addAll(updatedSummary);
      _isEditMode = false;
    });

    _saveSummaryToFirestore();
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
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.save : Icons.edit,
            color: Colors.brown[700],
            size: 35,
            ),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
          ),
        ],
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
                  if ((widget.userEmail == 'lekin@gmail.com' && storeName == 'เล็กอิน') ||
                      (widget.userEmail == 'konong@gmail.com' && storeName == 'โกโหน่ง'))
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
                              child: TextField(
                                controller: _controllers[storeName]?[entry.key] ?? TextEditingController(),
                                decoration: InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                enabled: _isEditMode,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                                   child: TextField(
                                controller: _weightControllers[storeName]?[entry.key] ?? TextEditingController(),
                                decoration: InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                enabled: _isEditMode,
                              ),
                            )
                          ),
                        ],
                      );
                    }),
              ],
            ),
            // SizedBox(height: 20),
            // Text(
            //   'ยอดรวมทุกประเภท:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            // Table(
            //   border: TableBorder.all(),
            //   children: [
            //     TableRow(
            //       children: [
            //         TableCell(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               'ประเภท',
            //               style: TextStyle(
            //                   fontSize: 18, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ),
            //         TableCell(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               'ยอดขาย',
            //               style: TextStyle(
            //                   fontSize: 18, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ),
            //         TableCell(
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               'น้ำหนัก',
            //               style: TextStyle(
            //                   fontSize: 18, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     for (var entry in widget.totalPricesByType.entries)
            //       TableRow(
            //         children: [
            //           TableCell(
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(entry.key),
            //             ),
            //           ),
            //           TableCell(
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(entry.value.toStringAsFixed(2)),
            //             ),
            //           ),
            //           TableCell(
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Text(widget.totalWeightsByType[entry.key]!
            //                   .toStringAsFixed(2)),
            //             ),
            //           ),
            //         ],
            //       ),
            //   ],
            // ),
            // SizedBox(height: 20),
            // Container(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: _createPDF,
            //     child: Text('ดาวน์โหลด PDF'),
            //   ),
            // ),
            // SizedBox(height: 20),
            // Container(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         _isEditMode = !_isEditMode;
            //       });
            //     },
            //     child: Text(_isEditMode ? 'บันทึกการแก้ไข' : 'แก้ไข'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
