import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/storeview/formrubyang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCust extends StatefulWidget {
  // final Function(String) navigateToPaymentPage; // Callback function

  // OrderCust({required this.navigateToPaymentPage});
  @override
  _OrderCustState createState() => _OrderCustState();
}

class _OrderCustState extends State<OrderCust> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายการขายยาง"),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("orderrequet").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: snapshot.data!.docs.map<Widget>((orderrequetDocument) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "อีเมล์ชาวสวน: ${orderrequetDocument["emailfarmer"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                               SizedBox(height: 10),
                               Text(
                                  "เลขที่คำสั่งขาย ${orderrequetDocument.id}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              SizedBox(height:5),
                              Text("วันนี้: ${orderrequetDocument["date"]}"),
                              Text(
                                  "เวลาที่เลือก: ${orderrequetDocument["time"]}"),
                              Text(
                                  "ร้านรับซื้อ: ${orderrequetDocument["store"]}"),
                              Text("ราคา: ${orderrequetDocument["price"]} บาท"),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.brown,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                    "สถานะ: ${orderrequetDocument["status"]}"),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("orderrequet")
                                        .doc(orderrequetDocument.id)
                                        .update({"status": "รับยางพาราแล้ว"});

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Formrubyang(
                                          selectedStoreName:
                                              orderrequetDocument["store"],
                                          priceSheets:
                                              orderrequetDocument["price"],
                                              orderId: orderrequetDocument.id, 
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green[
                                        700], 
                                  ),
                                  child: Text(
                                    "ยืนยันการซื้อขาย",
                                    style: TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}


// class OrderCust extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ยืนยันการสั่งซื้อ'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Consumer2<SelectedDateTimeProvider, ListProvider>(
//           builder: (context, selectedDateTimeProvider, listProvider, _) {
//             final selectedDate = selectedDateTimeProvider.selectedDate;
//             final selectedTime = selectedDateTimeProvider.selectedTime;
//             final selectedStoreName =
//                 selectedDateTimeProvider.selectedStoreName;
//             final priceSheets = selectedDateTimeProvider.priceSheets;
//             final status = selectedDateTimeProvider.status;
//             // final emailfarmer = auth.currentUser?.email ?? '';
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: selectedTime.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           ListTile(
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 8.0,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                               side: BorderSide(
//                                 color: Colors.brown[800]!,
//                                 width: 4.0,
//                               ),
//                             ),
//                             title: Text(
//                               'วันที่เลือก:${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.brown[800],
//                               ),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                  SizedBox(height: 10),
//                                 Text(
//                                   ': ${status}',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                  SizedBox(height: 10),
//                                 Text(
//                                   'เวลาที่เลือก:${selectedTime[index]}',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.brown[800],
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   'ร้านรับซื้อที่เลือก : $selectedStoreName',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 Text(
//                                   'ราคา: ${priceSheets[0]} บาท',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                  SizedBox(height: 10),
//                                 Text(
//                                   'สถานะ: ${status}',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             trailing: ElevatedButton(
//                               onPressed: () {
//                                 selectedDateTimeProvider.setStoreAndPrice(
//                                   store: selectedStoreName,
//                                   prices: priceSheets,
//                                 );
//                                 selectedDateTimeProvider.addBooking(
//                                   date:
//                                       '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                                   time: selectedTime[index],
//                                   selectedStoreName: selectedStoreName,
//                                   priceSheets: priceSheets,
//                                   status: status,
//                                 );
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Formrubyang(
//                                       selectedStoreName: selectedStoreName,
//                                       priceSheets: priceSheets,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'ยืนยัน',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green[600],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           buildList(context, index),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 // Add Consumer for ListProvider here
//                 Consumer<ListProvider>(
//                   builder: (context, provider, _) {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: provider.list.length,
//                         itemBuilder: (context, index) =>
//                             buildList(context, index),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildList(BuildContext context, int index) {
//     final listProvider = Provider.of<ListProvider>(context);
//     if (index >= 0 && index < listProvider.list.length) {
//       return Dismissible(
//         key: Key(index.toString()),
//         direction: DismissDirection.startToEnd,
//         onDismissed: (direction) {
//           listProvider.deleteItem(index);
//         },
//         child: Container(
//           margin: EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blue,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: ListTile(
//             title: Text(listProvider.list[index]),
//             trailing: Icon(Icons.keyboard_arrow_right),
//           ),
//         ),
//       );
//     } else {
//       // Return an empty container or handle the case when index is out of range
//       return Container();
//     }
//   }
// }

// class DynamicList {
//   List<String> _list = [];

//   DynamicList(this._list);

//   List<String> get list => _list;

//   void deleteItem(int index) {
//     if (index >= 0 && index < _list.length) {
//       _list.removeAt(index);
//     }
//   }
// }

// class ListProvider with ChangeNotifier {
//   List<String> list = [];

//   void addItem(String item) {
//     list.add(item);
//     notifyListeners();
//   }

//   void deleteItem(int index) {
//     list.removeAt(index);
//     notifyListeners();
//   }
// }

// class DynamicList {
//   List<String> _list = [];
//   DynamicList(this._list);

//   List get list => _list;
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rub_yang/Pages/timeslot.dart';
// import 'package:rub_yang/storeview/formrubyang.dart';
// class OrderCust extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ยืนยันการสั่งซื้อ'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Consumer2<SelectedDateTimeProvider, ListProvider>(
//           builder: (context, selectedDateTimeProvider, listProvider, _) {
//             final selectedDate = selectedDateTimeProvider.selectedDate;
//             final selectedTime = selectedDateTimeProvider.selectedTime;
//             final selectedStoreName = selectedDateTimeProvider.selectedStoreName;
//             final priceSheets = selectedDateTimeProvider.priceSheets;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: selectedTime.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           ListTile(
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 8.0,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                               side: BorderSide(
//                                 color: Colors.brown[800]!,
//                                 width: 4.0,
//                               ),
//                             ),
//                             title: Text(
//                               'วันที่เลือก:${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.brown[800],
//                               ),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'เวลาที่เลือก:${selectedTime[index]}',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.brown[800],
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   'ร้านรับซื้อที่เลือก : $selectedStoreName',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 Text(
//                                   'ราคา: ${priceSheets[0]} บาท',
//                                   style: TextStyle(
//                                     color: Colors.brown[800],
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             trailing: ElevatedButton(
//                               onPressed: () {
//                                 selectedDateTimeProvider.setStoreAndPrice(
//                                   store: selectedStoreName,
//                                   prices: priceSheets,
//                                 );
//                                 selectedDateTimeProvider.addBooking(
//                                   date: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                                   time: selectedTime[index],
//                                   selectedStoreName: selectedStoreName,
//                                   priceSheets: priceSheets,
//                                 );

//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Formrubyang(
//                                       selectedStoreName: selectedStoreName,
//                                       priceSheets: priceSheets,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'ยืนยัน',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green[600],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           buildList(context, index),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 // Add Consumer for ListProvider here
//                 Consumer<ListProvider>(
//                   builder: (context, provider, _) {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: provider.list.length,
//                         itemBuilder: (context, index) => buildList(context, index),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
