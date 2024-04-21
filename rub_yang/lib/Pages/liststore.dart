// import 'package:flutter/material.dart';
// import 'package:rub_yang/Pages/formtrade.dart';

// class ListStore extends StatelessWidget {
//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'ร้านรับยาง',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child:Padding(
//               padding: const EdgeInsets.symmetric(horizontal:BorderSide.strokeAlignCenter),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing:10 ,
//                childAspectRatio: 0.8,
//               ),
//               itemCount: stores.length,
//               itemBuilder: (context, index) => StoreCard(store: stores[index]),
//             ),
//           ),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//       color: Theme.of(context).colorScheme.inversePrimary,
//       child: Container(
//         height: kBottomNavigationBarHeight - 30,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               onPressed: () {
//                  Navigator.pushNamed(context, '/9');
//               },
//               icon: Icon(Icons.home),
//               color: Colors.brown,
//               iconSize: 40,
//             ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }
// }
// class StoreCard extends StatelessWidget {
//   final Store store;
//    StoreCard({required this.store});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => Formtrade(),
//           ),
//         );
//       },
//     child: Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.asset(
//               store.image,
//               width: 80, 
//               height: 80, 
//               fit: BoxFit.cover, 
//             ),
//           Text(
//             store.title,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           Text(' ที่ตั้ง: ${store.location}',
//           style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//            ),
//           ),
//           // Text(
//           // 'เรทราคา= ${store.price.toString()} บาท/กก',
//           // style: TextStyle(
//           // color: Colors.black,
//           // fontWeight: FontWeight.bold,
//           //  ),
//           // ),
//           Text(
//           'ชนิดที่รับซื้อ= ${store.description.toString()}',
//           style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//            ),
//           ),
//          ],
//         ),
//       ),
//     );
//   }
// }
// class Store {
//   final String image, title, description, location;
//   final int price, id;

//   Store({
//     required this.id,
//     required this.image,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.location,
//   });
// }
// List<Store> stores = [
//   Store(
//     id: 1,
//     title: "ร้านเล็ก",
//     price: 45,
//     description: 'แบบน้ำ',
//     image: "images/rubber_c.jpg",
//     location: "บ้านตาขุน \n สุราษฎร์ธานี",
//   ),
//   Store(
//     id: 2,
//     title: "ร้านโกโหน่ง",
//     price: 50,
//     description: 'แบบแผ่น \n แบบก้อน',
//     image: "images/rubber_b.jpg",
//     location: "ตลาดบ้านส้อง อ.เวียงสระ จ.สุราษฎร์ธานี",
//   ),
// ];
