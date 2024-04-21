import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/timeslot.dart';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/storeview/formrubyang.dart';

class ConfirmBK extends StatelessWidget {
  final String storeName;
  final num dailyPrice;
  const ConfirmBK({
    Key? key,
    required this.storeName,
    required this.dailyPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยืนยันการสั่งซื้อ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<SelectedDateTimeProvider>(
          builder: (context, selectedDateTimeProvider, _) {
            final selectedDate = selectedDateTimeProvider.selectedDate;
            final selectedTime = selectedDateTimeProvider.selectedTime;
            return Consumer<StoresProvider>(
              builder: (context, storeProvider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedTime.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                      color: Colors.brown[800]!, width: 4.0),
                                ),
                                title: Text(
                                  'วันที่เลือก:${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.brown[800],
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'เวลาที่เลือก:${selectedTime[index]}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.brown[800],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'ร้านรับซื้อที่เลือก : $storeName',
                                      style: TextStyle(
                                        color: Colors.brown[800],
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'ราคา: $dailyPrice',
                                      style: TextStyle(
                                          color: Colors.brown[800],
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                trailing:   ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Formrubyang(
                                        dailyPrice: dailyPrice,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('ยืนยัน',
                                 style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                      color: Colors.green[600],
                                      fontSize: 14),
                                ),
                              ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ...selectedDateTimeProvider.bookings
                        .map((booking) {})
                        .toList(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// class Bookingorder extends StatelessWidget {
//   final Map<String, dynamic> booking;
//   final String selectedStore;
//   final num updatePrice;

//   Bookingorder({
//     required this.booking,
//     required this.selectedStore,
//     required this.updatePrice,
//   });

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     margin: EdgeInsets.all(10),
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       side: BorderSide(color: Colors.brown, width: 1.5),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
            // Text(
            //   'วันที่: ${booking['date']}',
            //   style: TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'เวลา: ${booking['time']}',
            //   style: TextStyle(fontSize: 16),
            // ),

            // Text(
            //   'ร้าน: $selectedStore',
            //   style: TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'ราคา: $updatePrice',
            //   style: TextStyle(fontSize: 16),
            // ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Formrubyang(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'ยืนยัน',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
