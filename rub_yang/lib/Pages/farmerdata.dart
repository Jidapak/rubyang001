// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Farmerdata extends StatefulWidget {
//   @override
//   _FarmerdataState createState() => _FarmerdataState();
// }

// class _FarmerdataState extends State<Farmerdata> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'ชาวสวนที่มีต้นไม้อายุเกิน 25 ปี',
//           style: TextStyle(
//             fontSize: 18.0,
//             letterSpacing: 1.5,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("farmerdata").snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView(
//             children: snapshot.data!.docs.map((document) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 16.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.brown[800],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     title: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ชื่อชาวสวน: ${document["namefarmer"]} "
//                             " ${document["lastnfarmer"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "สัญชาติ: ${document["nationality"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "ที่อยู่: ${document["location"]}""  "
//                             " ${document["selectedCity"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                              "จังหวัด: ${document["selectedState"]} "
//                             " ${document["selectedCountry"]}",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "ขนาดฟาร์ม: ${document["areafarm"]} ไร่",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "จำนวนต้นยาง: ${document["quantitytree"]} ต้น",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "จำนวนต้นยางอายุ>25ปี: ${document["agetree"]} ",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "เป็นเจ้าของสวน ?: ${document["_radioValue11"]} ต้น",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                            Text(
//                             "เข้าร่วมโครงการกยท ?: ${document["_radioValue12"]} ต้น",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
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