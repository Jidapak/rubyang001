// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class PriceCollect extends StatefulWidget {
//   final String selectedStoreName;
//   PriceCollect({required this.selectedStoreName});

//   @override
//   _PriceCollectState createState() => _PriceCollectState();
// }

// class _PriceCollectState extends State<PriceCollect> {
//   late CollectionReference _storeCollection;

//   @override
//   void initState() {
//     super.initState();
//     _storeCollection = FirebaseFirestore.instance.collection("prices");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "ราคาแต่ละชนิด",
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: _storeCollection.where("name_store", isEqualTo: widget.selectedStoreName).snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((storeDocument) {
//               // Access the fields directly from the document snapshot
//               String nameStore = storeDocument["name_store"];
//               Timestamp timestamp = storeDocument["today_date"];
//               DateTime dateTime = timestamp.toDate();
//               String formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
//               return GestureDetector(
//                 onTap: () {
//                   // Navigate to another page or handle onTap event
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.brown,
//                       width: 3,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.location_on,
//                               color: Colors.brown[900],
//                               size: 20,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "วันที่ $formattedDate",
//                               style: TextStyle(
//                                   fontSize: 16, color: Colors.brown[900]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "ชื่อร้าน ${widget.selectedStoreName}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.brown[900],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       ...data.entries.map((entry) {
//                         if (entry.key != "name_store" &&
//                             entry.key != "district" &&
//                             entry.key != "today_date" &&
//                             entry.key != "telnum") {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "${entry.key}: ${entry.value}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.brown[900],
//                               ),
//                             ),
//                           );
//                         } else {
//                           return SizedBox.shrink();
//                         }
//                       }).toList(),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
