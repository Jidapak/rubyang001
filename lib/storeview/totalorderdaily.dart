import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rub_yang/storeview/dailysummary.dart';

class TotlalOrderReq extends StatefulWidget {
  @override
  _TotlalOrderReqState createState() => _TotlalOrderReqState();
}

class _TotlalOrderReqState extends State<TotlalOrderReq> {
  DateTime selectedDate = DateTime.now();
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _getCurrentUserEmail();
  }

  void _getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? "";
      setState(() {
        userEmail = email; // Store the user's email
      });
    }
  }

  Stream<QuerySnapshot> _getOrdersStream() {
    return FirebaseFirestore.instance
        .collection("calculateorders")
        .where(
          "timestamp",
          isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
            selectedDate.millisecondsSinceEpoch,
          ),
        )
        .where(
          "timestamp",
          isLessThan: Timestamp.fromMillisecondsSinceEpoch(
            selectedDate.add(Duration(days: 1)).millisecondsSinceEpoch,
          ),
        )
        .snapshots();
  }

  Map<String, Map<String, dynamic>> calculateDailySummary(QuerySnapshot snapshot) {
    Map<String, Map<String, dynamic>> dailySummary = {};
    for (var document in snapshot.docs) {
      String? type = document["Type"];
      double? totalPrice = document["totalPrice"]?.toDouble();
      double? weight = document["weightoftotal"]?.toDouble();
      String? storeName = document["selectedStoreName"];

      if (type != null && totalPrice != null && storeName != null) {
        if (!dailySummary.containsKey(storeName)) {
          dailySummary[storeName] = {
            'ยางก้อน': {'totalPrice': 0.0, 'weight': 0.0},
            'ยางแผ่น': {'totalPrice': 0.0, 'weight': 0.0},
            'น้ำยาง': {'totalPrice': 0.0, 'weight': 0.0},
          };
        }
        dailySummary[storeName]![type]['totalPrice'] =
            (dailySummary[storeName]![type]['totalPrice'] ?? 0) + totalPrice;
        dailySummary[storeName]![type]['weight'] =
            (dailySummary[storeName]![type]['weight'] ?? 0) + weight!;
      }
    }
    return dailySummary;
  }

  void _showDailySummary(
    Map<String, Map<String, dynamic>> dailySummary,
    Map<String, double> totalPricesByType,
    Map<String, double> totalWeightsByType,
  ) {
    if (userEmail != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DailySummaryPage(
            dailySummary: dailySummary,
            totalPricesByType: totalPricesByType,
            totalWeightsByType: totalWeightsByType,
            selectedDate: selectedDate,
            userEmail: userEmail!, // Pass the userEmail here
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> totalPricesByType = {
      'ยางก้อน': 0.0,
      'ยางแผ่น': 0.0,
      'น้ำยาง': 0.0,
    };

    Map<String, double> totalWeightsByType = {
      'ยางก้อน': 0.0,
      'ยางแผ่น': 0.0,
      'น้ำยาง': 0.0,
    };

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ยอดรวมวันนี้",
              style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 2.0,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "อีเมล์ผู้ใช้: $userEmail ",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.brown,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            color: Colors.brown,
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.price_change_rounded),
            color: Colors.brown,
            onPressed: () async {
              QuerySnapshot snapshot = await _getOrdersStream().first;
              Map<String, Map<String, dynamic>> dailySummary =
                  calculateDailySummary(snapshot);

              dailySummary.forEach((storeName, typeData) {
                typeData.forEach((type, data) {
                  totalPricesByType[type] =
                      (totalPricesByType[type] ?? 0) + data['totalPrice'];
                  totalWeightsByType[type] =
                      (totalWeightsByType[type] ?? 0) + data['weight'];
                });
              });

              _showDailySummary(
                dailySummary,
                totalPricesByType,
                totalWeightsByType,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _getOrdersStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          snapshot.data!.docs.forEach((document) {
            String type = document["Type"] as String;
            double totalPrice = document["totalPrice"]?.toDouble() ?? 0.0;
            double weight = document["weightoftotal"]?.toDouble() ?? 0.0;

            totalPricesByType[type] =
                (totalPricesByType[type] ?? 0) + totalPrice;
            totalWeightsByType[type] =
                (totalWeightsByType[type] ?? 0) + weight;
          });

          Set<String> uniqueOrderIds = {};
          List<DataRow> dataRows = [];

          for (var document in snapshot.data!.docs) {
            String orderId = document["orderId"] as String;
            if (!uniqueOrderIds.contains(orderId)) {
              uniqueOrderIds.add(orderId);

              // Add the DataRow for this document to the list
              Timestamp timestamp = document["timestamp"] as Timestamp;
              DateTime dateTime = timestamp.toDate();
              String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

              dataRows.add(
                DataRow(cells: [
                  DataCell(Text(formattedDate)),
                  DataCell(
                    Row(
                      children: [
                        Text("$orderId"),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["selectedStoreName"]}"),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["Type"]}"),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text("${document["weightoftotal"]}"),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text(
                            "${document["totalPrice"]?.toStringAsFixed(2) ?? '0.00'}"),
                      ],
                    ),
                  ),
                ]),
              );
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'วันที่',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เลขคำสั่งซื้อ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ร้านรับซื้อ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ชนิดยาง',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'น้ำหนัก',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ราคารวม',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: dataRows,
            ),
          );
        },
      ),
    );
  }
}

void _showDailySummary(
  BuildContext context, // Add BuildContext parameter here
  Map<String, Map<String, dynamic>> dailySummary,
  Map<String, double> totalPricesByType,
  Map<String, double> totalWeightsByType,
  DateTime selectedDate,
  String userEmail,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => DailySummaryPage(
         userEmail: userEmail!,
        dailySummary: dailySummary,
        totalPricesByType: totalPricesByType,
        totalWeightsByType: totalWeightsByType,
        selectedDate: selectedDate,
      ),
    ),
  );
}
