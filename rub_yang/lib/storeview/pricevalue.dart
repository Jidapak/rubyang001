import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceValue extends StatefulWidget {
  @override
  _PriceValueState createState() => _PriceValueState();
}
class _PriceValueState extends State<PriceValue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ราคากลางของการยาง",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("centerprices").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              Timestamp timestamp = document["today_date"] as Timestamp;
              DateTime dateTime = timestamp.toDate();
              String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ราคาวันนี้: ${document["update_price"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
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
}

// class _PriceValueState extends State<PriceValue> {
//   double currentPrice = 0.0;
//   void updatePrice(double newValue) {
//     setState(() {
//       currentPrice = newValue;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ราคาเปิด'),
//         titleTextStyle: 
//          TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               double newPrice = 40.00;
//               updatePrice(newPrice);
//             },
//             icon: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'ราคาประจำวัน:',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0),
//             ),
//             Text(
//               '\$${currentPrice.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontSize: 24.0, 
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white
//                 ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 double newPrice = 40.00;
//                 updatePrice(newPrice);
//               },
//               child: Text('อัปเดตราคา',
//                style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.brown,
//             )
//               ),
//             ),
//            Text('ราคาย้อนหลัง7วัน' ,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//            ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 7,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       leading: CircleAvatar(),
//                       title: Text(
//                         'ราคาวันที่ ${index + 1} :\   __',
//                         style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.brown,
//                       ),
//                     ),
//                   ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
