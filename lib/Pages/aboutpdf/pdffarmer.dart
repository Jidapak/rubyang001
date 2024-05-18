// import 'dart:typed_data'; // Import the dart:typed_data library
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class PrintPdfPage extends StatelessWidget {
//   final List<DocumentSnapshot> farmerData;

//   PrintPdfPage({required this.farmerData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('พิมพ์ PDF'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Printing.layoutPdf(
//               onLayout: (format) => _generatePdf(),
//             );
//           },
//           child: Text('พิมพ์ PDF'),
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _generatePdf() async {
//     final pdf = pw.Document();
// final font = await PdfGoogleFonts.sarabunRegular();
//     pdf.addPage(
//       pw.Page(
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.Header(level: 0, child: pw.Text('ชาวสวนที่จะเข้าร่วมขอทุนกยท')),
//               pw.ListView.builder(
//                 itemCount: farmerData.length,
//                 itemBuilder: (context, index) {
//                   final document = farmerData[index];
//                   return pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text(
//                         "ชื่อชาวสวน: ${document["namefarmer"]} ${document["lastnfarmer"]}",
//                         style: pw.TextStyle(font: font),
//                       ),
//                       pw.Text(
//                         "สัญชาติ: ${document["nationality"]}",
//                         style: pw.TextStyle(font: font),
//                       ),
//                       pw.Text(
//                         "ที่อยู่: ${document["location"]} ${document["selectedCity"]}",
//                         style: pw.TextStyle(font: font),
//                       ),
//                       // Add more fields as needed
//                       pw.Divider(),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }
// }
