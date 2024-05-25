import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PriceStore extends StatefulWidget {
  @override
  _PriceStoreState createState() => _PriceStoreState();
}

class _PriceStoreState extends State<PriceStore> {
  String? selectedStoreName;
  String? selectedDistrict; // Added district variable
  Map<String, Map<int, double>> updatedPrices = {};
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController districtController = TextEditingController(); // Added district controller

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

  void adjustPrice(String docId, int index, double adjustment) {
    setState(() {
      if (!updatedPrices.containsKey(docId)) {
        updatedPrices[docId] = {};
      }
      if (!updatedPrices[docId]!.containsKey(index)) {
        updatedPrices[docId]![index] = 0.0;
      }
      updatedPrices[docId]![index] = updatedPrices[docId]![index]! + adjustment;
    });
  }

  double getUpdatedPrice(String docId, int index, double originalPrice) {
    if (updatedPrices.containsKey(docId) &&
        updatedPrices[docId]!.containsKey(index)) {
      return originalPrice + updatedPrices[docId]![index]!;
    }
    return originalPrice;
  }

  void savePrices() async {
    final firestoreInstance = FirebaseFirestore.instance;

    updatedPrices.forEach((docId, priceUpdates) async {
      final documentSnapshot = await firestoreInstance.collection("centerprices").doc(docId).get();
      final documentData = documentSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> priceList = documentData['priceList'];

      // Sort the priceList by date to ensure the latest date is processed
      priceList.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));

      // Filter for the latest date entries only
      final latestDate = priceList.first['date'];
      final latestPriceList = priceList.where((price) => price['date'] == latestDate).toList();

      priceUpdates.forEach((index, adjustment) async {
        final originalPrice = latestPriceList[index]['price_max'];
        final updatedPrice = originalPrice + adjustment;
        final String date = latestPriceList[index]['date'];
        final String type = documentData['type'];

        await firestoreInstance.collection("prices").add({
          'date': date,
          'original_price': originalPrice,
          'adjusted_price': updatedPrice,
          'type': type,
          'storeName': selectedStoreName,
          'district': selectedDistrict, // Include district in the data
        });
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('บันทึกราคาสำเร็จ')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อัพเดทราคา",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: storeNameController,
              decoration: InputDecoration(
                labelText: 'ชื่อร้าน',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedStoreName = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: districtController,
              decoration: InputDecoration(
                labelText: 'อำเภอ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("centerprices")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Process the documents to find the latest date and filter the entries
                Map<String, List<Map<String, dynamic>>> latestPriceData = {};

                for (var document in snapshot.data!.docs) {
                  final data = document.data() as Map<String, dynamic>?;
                  if (data != null && data.containsKey('priceList')) {
                    final rawPriceList = data['priceList'] as List<dynamic>?;
                    if (rawPriceList != null && rawPriceList.isNotEmpty) {
                      // Sort the priceList by date to ensure the latest date is identified
                      rawPriceList.sort((a, b) => (b['date'] as String).compareTo(a['date'] as String));

                      // Get the latest date
                      final latestDate = rawPriceList.first['date'];

                      // Filter for the latest date entries only and limit to 3 entries
                      final latestPriceList = rawPriceList
                          .where((price) => price['date'] == latestDate)
                          .take(3)
                          .toList();

                      // Store the filtered latest price list for this document
                      latestPriceData[document.id] = latestPriceList.whereType<Map<String, dynamic>>().toList();
                    }
                  }
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('วันที่')),
                      DataColumn(label: Text('ราคา')),
                      DataColumn(label: Text('ปรับราคา')),
                      DataColumn(label: Text('ชนิดยาง')),
                    ],
                    rows: latestPriceData.entries.expand((entry) {
                      final documentId = entry.key;
                      final priceList = entry.value;
                      final documentData = snapshot.data!.docs.firstWhere((doc) => doc.id == documentId).data() as Map<String, dynamic>?;
                      final String type = documentData?['type'] ?? 'N/A';

                      return priceList.map((price) {
                        final String date = price["date"] ?? 'N/A';
                        final double priceMax = price["price_max"]?.toDouble() ?? 0.0;
                        final int index = priceList.indexOf(price);

                        return DataRow(
                          cells: [
                            DataCell(Text(date)),
                            DataCell(Text(priceMax.toStringAsFixed(2))),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      adjustPrice(documentId, index, -0.05);
                                    },
                                  ),
                                  Text(
                                    (updatedPrices[documentId]?[index] != null 
                                      ? (updatedPrices[documentId]![index]! + priceMax).toStringAsFixed(2) 
                                      : priceMax.toStringAsFixed(2))),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      adjustPrice(documentId, index, 0.05);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            DataCell(Text(type)),
                          ],
                        );
                      }).toList();
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: savePrices,
              child: Text('บันทึกราคา'),
            ),
          ),
        ],
      ),
    );
  }
}
