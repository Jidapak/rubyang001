// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rub_yang/facview/formtofactory.dart';

// class QuanlityDisplay extends StatelessWidget {
//  @override
//   Widget build(BuildContext context) {
//     return Consumer<OrderRequestModel>(
//       builder: (context, orderRequestmodel, child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'quanli',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 letterSpacing: 2.0,
//                 color: Colors.brown,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           body: ListView.builder(
//             itemCount: orderRequestmodel.orders.length,
//             itemBuilder: (context, index) {
//               final order = orderRequestmodel.orders[index];
//               return OrderItem(order: order);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// class OrderItem extends StatelessWidget {
//   final Map<String, dynamic> order;

//   OrderItem({required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: Colors.brown, width: 1.5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order No: ${order['no']}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Colors.brown,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Price: ${order['price']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Weight: ${order['weight']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Date: ${order['date']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Time: ${order['time']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'รูปแบบการซื้อขาย: ${order['radioTrade1']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'รููปแบบยางพารา: ${order['radioTrade2']}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }