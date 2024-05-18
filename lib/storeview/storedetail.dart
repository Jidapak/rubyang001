// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rub_yang/model/storemodel.dart';
// import 'package:rub_yang/service/storeservice.dart';
// import 'package:rub_yang/storeview/app.dart';

// class Store_Detail extends StatefulWidget {
//   @override
//    Store_DetailState createState() => Store_DetailState();
// }
// class Store_DetailState extends State<Store_Detail> {
//   late Future<List<Store>> storesFuture;
//   @override
//   void initState() {
//     super.initState();
//     storesFuture = Stores_Service().fetchStores();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stores'),
//       ),
//       body: FutureBuilder<List<Store>>(
//         future: storesFuture,
//         builder: (context, snapshot) {
//           if (
//             snapshot.connectionState == ConnectionState.waiting
//             ) {
//             return Center(
//               child: CircularProgressIndicator()
//               );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(' ${snapshot.error}')
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//               print(snapshot.data);
//                 Store store = snapshot.data![index];
//                 return StoreItem(store: store);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// class StoreItem extends StatelessWidget {
//   final Store store;
//   const StoreItem ({Key? key, required this.store}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Provider.of<StoreProvider>(context, listen: false)
//             .setListStore(store);
//             Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Store_Detail(),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity, 
//         margin: EdgeInsets.all(8.0),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('district: ${store.district}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 18,
//                         ),
//                     ),
//                     Text('namestore: ${store.namestore}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                         ),
//                     ),
//                     Text('province: ${store.province}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                         ),
//                     ),
//                     Text('subdistrict: ${store.subdistrict}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                         ),
//                     ),
//                     Text('telnum: ${store.telnum}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                         ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
