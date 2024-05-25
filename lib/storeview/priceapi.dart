import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PriceAPI extends StatefulWidget {
  @override
  _PriceAPIState createState() => _PriceAPIState();
}

class _PriceAPIState extends State<PriceAPI> {
  final ApiService apiService = ApiService();
  late Future<Map<String, dynamic>> futureData1;
  late Future<Map<String, dynamic>> futureData2;
  late Future<Map<String, dynamic>> futureData3;

  // Initialize Firestore
  final CollectionReference priceCollection =
      FirebaseFirestore.instance.collection('centerprices');

  @override
  void initState() {
    super.initState();
    futureData1 = apiService.fetchData("W16026", "2024-05-24", "2024-05-24");
    futureData2 = apiService.fetchData("W16034", "2024-05-24", "2024-05-24");
    futureData3 = apiService.fetchData("W16036", "2024-05-24", "2024-05-24");

    // Call function to send data to Firestore
    sendDataToFirestore();
  }

  void sendDataToFirestore() async {
  try {
    // Fetch data for all types
    Map<String, dynamic> data1 = await futureData1;
    Map<String, dynamic> data2 = await futureData2;
    Map<String, dynamic> data3 = await futureData3;

    // Combine data for all types into a single list
    List<Map<String, dynamic>> allData = [
      {'type': 'ยางก้อน', 'priceList': data1['price_list']},
      {'type': 'ยางน้ำ', 'priceList': data2['price_list']},
      {'type': 'ยางแผ่น', 'priceList': data3['price_list']},
    ];

    // Send combined data to Firestore
    for (var data in allData) {
      await priceCollection.add(data);
    }

    print('Data sent to Firestore successfully!');
  } catch (error) {
    print('Error sending data to Firestore: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ราคากลาง",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDataTable(futureData1, "ยางก้อน"),
            buildDataTable(futureData2, "ยางน้ำ"),
            buildDataTable(futureData3, "ยางแผ่น"),
          ],
        ),
      ),
    );
  }


  Widget buildDataTable(Future<Map<String, dynamic>> futureData, String title) {
    return FutureBuilder<Map<String, dynamic>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("No data found for $title");
        } else {
          var data = snapshot.data!;
          var priceList = data['price_list'] as List<dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ชนิดยาง: $title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DataTable(
                columns: [
                  DataColumn(label: Text('วันที่')),
                  DataColumn(label: Text('ราคา')),
                ],
                rows: priceList.map((price) {
                  return DataRow(
                    cells: [
                      DataCell(Text(price['date'] ?? 'N/A')),
                      DataCell(Text(price['price_max'].toString() ?? 'N/A')),
                    ],
                  );
                }).toList(),
              ),
              Divider(),
            ],
          );
        }
      },
    );
  }
}
