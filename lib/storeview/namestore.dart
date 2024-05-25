import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/timeslot.dart';

class NameStore extends StatefulWidget {
  final String selectedStoreName;
  NameStore({required this.selectedStoreName});
  @override
  _NameStoreState createState() => _NameStoreState();
}

class _NameStoreState extends State<NameStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ร้านรับซื้อยาง",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("prices")
            // .where("storeName", isEqualTo: widget.selectedStoreName)
            .orderBy("date", descending: true)
            .limit(3)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, List<num>> pricesByRubberType =
              {}; // สร้างรายการราคาตามชนิดของยาง

          snapshot.data!.docs.forEach((document) {
            String rubberType = document["type"];
            num adjustedPrice = document["adjusted_price"] as num;

            if (!pricesByRubberType.containsKey(rubberType)) {
              pricesByRubberType[rubberType] = [];
            }
            // เพิ่มราคาลงในรายการที่มีอยู่แล้ว
            pricesByRubberType[rubberType]!.add(adjustedPrice);
          });

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  String selectedStoreName = widget.selectedStoreName;
                  String rubberType = document["type"];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimeSlot(
                        priceSheets: pricesByRubberType[rubberType] ?? [],
                        selectedStoreName: selectedStoreName,
                        rubberType: rubberType,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ร้านรับซื้อ: ${document["storeName"]}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'อำเภอ: ${document["district"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'วันที่: ${document["date"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'ราคา: ${document["adjusted_price"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'ชนิดยางพารา: ${document["type"]}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
