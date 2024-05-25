import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/displayconfirm.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
import 'package:rub_yang/storeview/ordercusto.dart';

const List<String> TIME_SLOT = [
  '07:30 AM', '08:00 AM', '08:30 AM', '09:00 AM', '09:30 AM',
  '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM', '12:00 PM',
  '01:00 PM', '01:30 PM', '02:00 PM', '02:30 PM', '03:00 PM',
];

class TimeSlot extends StatefulWidget {
  final String selectedStoreName;
  final List<num> priceSheets;
  final String? rubberType;
  TimeSlot({
    required this.priceSheets,
    required this.selectedStoreName,
    this.rubberType,
  });
  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String? _selectedPaymentMethod;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  late CollectionReference _orderrequestCollection;
  late Future<FirebaseApp> _firebase;
  late orderrequest myOrderreq;

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _orderrequestCollection = FirebaseFirestore.instance.collection("orderrequet");
    final selectedDateTimeProvider = Provider.of<SelectedDateTimeProvider>(context, listen: false);
    myOrderreq = orderrequest(
      "",
      "",
      "",
      DateFormat('dd/MM/yyyy').format(selectedDateTimeProvider.selectedDate),
      "",
      "",
      DateTime.now(),
      "",
      "",
      "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = Provider.of<SelectedDateTimeProvider>(context).selectedDate;
    final selectedTime = Provider.of<SelectedDateTimeProvider>(context).selectedTime;
    final selectedStore = Provider.of<SelectedDateTimeProvider>(context).selectedStoreName;
    final status = Provider.of<SelectedDateTimeProvider>(context).status;
    final selectedTimeProvider = Provider.of<SelectedDateTimeProvider>(context, listen: false);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Initialize _formKey here

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'จองเวลาส่งยาง',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              auth.currentUser?.email ?? '',
              style: TextStyle(
                fontSize: 15,
                color: Colors.brown,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Text(
            'ร้านรับซื้อที่เลือก : ${widget.selectedStoreName}',
            style: TextStyle(
              color: Colors.brown[800],
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'ชนิดยาง: ${widget.rubberType}',
            style: TextStyle(
              color: Colors.brown[800],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'ราคาวันนี้: ${widget.priceSheets[0]}',
            style: TextStyle(color: Colors.brown[800], fontSize: 18),
          ),
          SizedBox(height: 20),
          Divider(),
          Text(
            'โปรดเลือกวิธีการรับเงิน:',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800]),
          ),
          SizedBox(height: 20),
          RadioListTile(
            title: Text('วิธีโอนเงิน'),
            value: 'โอนเงิน',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value as String?;
              });
            },
          ),
          RadioListTile(
            title: Text('วิธีเงินสด'),
            value: 'เงินสด',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value as String?;
              });
            },
          ),
          Divider(),
          Container(
            color: Colors.brown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            '${DateFormat.MMMM().format(selectedDate)}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'วันนี้: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: TIME_SLOT.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final slot = TIME_SLOT[index];
                final isSlotSelected = selectedTime.contains(slot);
                final currentCount = selectedTimeProvider.selectedCountPerSlot?[slot] ?? 0;
                return GestureDetector(
                  onTap: () {
                    if (isSlotSelected || currentCount >= 6) {
                      return;
                    }
                    selectedTimeProvider.selectTime(slot);
                    myOrderreq.selectedTime = slot;
                  },
                  child: Card(
                    color: isSlotSelected ? Colors.white10 : Colors.white,
                    child: GridTile(
                      header: isSlotSelected ? Icon(Icons.check) : null,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(slot),
                            Text(
                              currentCount >= 6
                                  ? 'Full ($currentCount)'
                                  : 'Available ($currentCount)',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Form(
            key: _formKey,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  var id = generateRandomId(10);
                  _orderrequestCollection.doc(id).set({
                    "price": widget.priceSheets,
                    "store": widget.selectedStoreName,
                    "date": myOrderreq.selectedDate,
                    "time": myOrderreq.selectedTime,
                    "today": myOrderreq.today_date,
                    "status": "ส่งคำสั่งขาย",
                    "emailfarmer": auth.currentUser?.email ?? '',
                    "rubberType": widget.rubberType,
                    "_selectedPaymentMethod": _selectedPaymentMethod,
                  });
                  print('เลข ID ของเอกสารที่เพิ่งสร้างขึ้น: $id');
                  _formKey.currentState?.reset();
                  final selectedDateTimeProvider =
                      Provider.of<SelectedDateTimeProvider>(context, listen: false);
                  final selectedDate = selectedDateTimeProvider.selectedDate;
                  final selectedTime = selectedDateTimeProvider.selectedTime.isNotEmpty
                      ? selectedDateTimeProvider.selectedTime[0]
                      : '';
                  if (selectedTime.isNotEmpty) {
                    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                    selectedDateTimeProvider.setStoreAndPrice(
                        store: widget.selectedStoreName,
                        prices: widget.priceSheets);
                    selectedDateTimeProvider.setStatus("ส่งคำสั่งขาย");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'เลขคำสั่งซื้อ:${id} \n วันที่จะมาส่ง: $formattedDate\nเวลาที่ส่ง: $selectedTime\n ราคา: ${widget.priceSheets} \n ร้านรับซื้อ: ${widget.selectedStoreName} \n สถานะ: ส่งคำสั่งขาย \n ชนิดยาง: ${widget.rubberType} \n วิธีรับเงิน: ${_selectedPaymentMethod}',
                        ),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmOrderPage(
                          id: id,
                          formattedDate: formattedDate,
                          selectedTime: selectedTime,
                          priceSheets: widget.priceSheets,
                          selectedStoreName: widget.selectedStoreName,
                          rubberType: widget.rubberType!,
                          selectedPaymentMethod: _selectedPaymentMethod,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณาเลือกเวลาก่อน'),
                      ),
                    );
                  }
                }
              },
              child: const Text('ส่งข้อมูล'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedDateTimeProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  List<String> _selectedTime = [];
  Map<String, int>? _selectedCountPerSlot = {};
  String _selectedStoreName = '';
  List<num> _priceSheets = [0]; // Initialize with default value
  String _status = "";
  DateTime get selectedDate => _selectedDate;
  List<String> get selectedTime => _selectedTime;
  Map<String, int>? get selectedCountPerSlot => _selectedCountPerSlot;
  String get selectedStoreName => _selectedStoreName;
  List<num> get priceSheets => _priceSheets; // Getter for priceSheets
  String get status => _status;

  void setStoreAndPrice({required String store, required List<num> prices}) {
    _selectedStoreName = store;
    _priceSheets = prices; // Set the priceSheets
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime.clear();
    if (time.isNotEmpty) {
      _selectedTime.add(time);
      _selectedCountPerSlot!.update(
        time,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    notifyListeners();
  }

  void setStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  final List<Map<String, dynamic>> _bookings = [];
  get bookings => _bookings;
  void addBooking({
    required String date,
    required String time,
    required String selectedStoreName,
    required List<num> priceSheets,
    required String status, // Include priceSheets here
  }) {
    _bookings.add({
      'date': date,
      'time': time,
      'selectedStoreName': selectedStoreName,
      'priceSheets': priceSheets,
      'status': status,
    });
    notifyListeners();
  }
}

class ListProvider with ChangeNotifier {
  List<String> list = [];
  get _list => list;
  void addItem(String item) {
    list.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}

class DynamicList {
  List<String> _list = [];
  DynamicList(this._list);

  List get list => _list;
}

class orderrequest {
  String id = "";
  String namefarmer = '';
  String selectedStoreName = '';
  String selectedDate = '';
  String priceSheets = '';
  String selectedTime = '';
  late DateTime today_date;
  late String status = '';
  late String rubberType = '';
  late String _selectedPaymentMethod = '';
  orderrequest(
    this.id,
    this.namefarmer,
    this.selectedStoreName,
    this.selectedDate,
    this.priceSheets,
    this.selectedTime,
    this.today_date,
    this.status,
    this.rubberType,
    this._selectedPaymentMethod,
  );
}

String generateRandomId(int length) {
  const characters = 'ABCDEFGHIJKLMN123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

// class SelectedDateTimeProvider extends ChangeNotifier {
//   DateTime _selectedDate = DateTime.now();
//   List<String> _selectedTime = [];
//   Map<String, int>? _selectedCountPerSlot = {};
//   String _selectedStoreName = '';
//   // List<num> _priceSheets = [0];

//   DateTime get selectedDate => _selectedDate;
//   List<String> get selectedTime => _selectedTime;
//   Map<String, int>? get selectedCountPerSlot => _selectedCountPerSlot;
//   String get selectedStoreName => _selectedStoreName;
//   // List<num> get priceSheets => _priceSheets;

//   void setStoreAndPrice({required String store}) {
//     _selectedStoreName = store;
//     // _priceSheets = price;
//     notifyListeners();
//   }

//   // void setPriceSheet({required List<num> pricesh}) {
//   //   _priceSheets = pricesh;
//   //   notifyListeners();
//   // }

//   void selectDate(DateTime date) {
//     _selectedDate = date;
//     notifyListeners();
//   }

//   void selectTime(String time) {
//     _selectedTime.clear();
//     if (time.isNotEmpty) {
//       _selectedTime.add(time);
//       _selectedCountPerSlot!.update(
//         time,
//         (value) => value + 1,
//         ifAbsent: () => 1,
//       );
//     }
//     notifyListeners();
//   }

//   final List<Map<String, dynamic>> _bookings = [];
//   get bookings => _bookings;

//   void addBooking({
//     required String date,
//     required String time,
//     required String selectedStoreName,
//     // required List<num> priceSheets,
//   }) {
//     _bookings.add({
//       'date': date,
//       'time': time,
//       'selectedStoreName': selectedStoreName,
//       // 'priceSheets': priceSheets,
//     });
//     notifyListeners();
//   }
// }

// const List<String> TIME_SLOT = [
//   '07:30 AM',
//   '08:00 AM',
//   '08:30 AM',
//   '09:00 AM',
//   '09:30 AM',
//   '10:00 AM',
//   '10:30 AM',
//   '11:00 AM',
//   '11:30 AM',
//   '12:00 PM',
//   '01:00 PM',
//   '01:30 PM',
//   '02:00 PM',
//   '02:30 PM',
//   '03:00 PM',
//   '03:30 PM',
//   '04:00 PM'
// ];

// class TimeSlot extends StatelessWidget {
//   final String selectedStoreName;
//   final List<num> priceSheets; // Declare priceSheets as a list
//   TimeSlot({required this.priceSheets, required this.selectedStoreName});
//   @override
//   Widget build(BuildContext context) {
//     final selectedDate =
//         Provider.of<SelectedDateTimeProvider>(context).selectedDate;
//     final selectedTime =
//         Provider.of<SelectedDateTimeProvider>(context).selectedTime;
//     // final selectedStore =
//     //     Provider.of<SelectedDateTimeProvider>(context)._selectedStore;
//     // final updatePrice =
//     //     Provider.of<SelectedDateTimeProvider>(context).priceSheets;
//     final selectedTimeProvider =
//         Provider.of<SelectedDateTimeProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'ตารางเวลานำยางมาขาย',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Text(
//             'ร้านรับซื้อที่เลือก : $selectedStoreName',
//             style: TextStyle(
//               color: Colors.brown[800],
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           Text(
//             'ราคาวันนี้: ${priceSheets[0]}',
//             style: TextStyle(color: Colors.brown[800], fontSize: 18),
//           ),
//           Container(
//             color: Colors.brown,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         children: [
//                           Text(
//                             '${DateFormat.MMMM().format(selectedDate)}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             'วันที่: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(Duration(days: 30)),
//                     );
//                     if (selectedDate != null) {
//                       selectedTimeProvider.selectDate(selectedDate);
//                     }
//                     // print('Selected Store: $storeName');
//                     // print('Update Price: $dailyPrice');
//                   },
//                   icon: Icon(Icons.calendar_today),
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               itemCount: TIME_SLOT.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//               ),
//               itemBuilder: (context, index) => GestureDetector(
//                 onTap: () {
//                   if (!selectedTime.contains(TIME_SLOT[index])) {
//                     if (selectedTimeProvider
//                                 .selectedCountPerSlot?[TIME_SLOT[index]]
//                                 ?.compareTo(6) !=
//                             null &&
//                         selectedTimeProvider
//                                 .selectedCountPerSlot![TIME_SLOT[index]]!
//                                 .compareTo(6) >=
//                             0) {
//                       return;
//                     }
//                     selectedTimeProvider.selectTime(TIME_SLOT[index]);
//                   } else {
//                     selectedTimeProvider.selectTime('');
//                   }
//                 },
//                 child: Card(
//                   color: selectedTime.contains(TIME_SLOT[index])
//                       ? Colors.white10
//                       : (selectedTime.isNotEmpty &&
//                               selectedTime[0] == TIME_SLOT[index]
//                           ? Colors.white54
//                           : Colors.white),
//                   child: GridTile(
//                     header: selectedTime.isNotEmpty &&
//                             selectedTime[0] == TIME_SLOT[index]
//                         ? Icon(Icons.check)
//                         : null,
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('${TIME_SLOT[index]}'),
//                           Text(selectedTime.contains(TIME_SLOT[index])
//                               ? (selectedTimeProvider.selectedCountPerSlot?[
//                                               TIME_SLOT[index]] !=
//                                           null &&
//                                       (selectedTimeProvider
//                                                       .selectedCountPerSlot?[
//                                                   TIME_SLOT[index]] ??
//                                               0) >
//                                           6
//                                   ? 'Full (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})'
//                                   : 'Available (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})')
//                               : 'Available (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})')
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final selectedDateTimeProvider =
//                   Provider.of<SelectedDateTimeProvider>(context, listen: false);
//               final selectedDate = selectedDateTimeProvider.selectedDate;
//               final selectedTime =
//                   selectedDateTimeProvider.selectedTime.isNotEmpty
//                       ? selectedDateTimeProvider.selectedTime[0]
//                       : '';
//               if (selectedTime.isNotEmpty) {
//                 final formattedDate =
//                     DateFormat('dd/MM/yyyy').format(selectedDate);

//                 // Show snackbar and navigate to ConfirmBK page
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       'วันที่จะมาส่ง: $formattedDate\nเวลาที่ส่ง: $selectedTime\n ราคา: $priceSheets \n,ร้าน: $selectedStoreName', 
//                     ),
//                   ),
//                 );
//                 print("will be push to ordercust ");
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OrderCust(
//                       priceSheets: priceSheets,
//                       selectedStoreName: selectedStoreName,
//                     ),
//                   ),
//                 );
//                 print("ราคา$priceSheets");
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('กรุณาเลือกเวลาก่อน'),
//                   ),
//                 );
//               }
//             },
//             child: Text('ส่งข้อมูล'),
//             style: ElevatedButton.styleFrom(
//               textStyle:
//                   TextStyle(fontSize: 18), // กำหนดขนาดตัวอักษรให้ใหญ่ขึ้น
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SelectedDateTimeProvider extends ChangeNotifier {
//   DateTime _selectedDate = DateTime.now();
//   List<String> _selectedTime = [];
//   Map<String, int>? _selectedCountPerSlot = {};
//   DateTime get selectedDate => _selectedDate;
//   List<String> get selectedTime => _selectedTime;
//   Map<String, int>? get selectedCountPerSlot => _selectedCountPerSlot;

//   String selectedStoreName = '';
//   num _priceSheets = 0;
//   String get _selectedStoreName => selectedStoreName;
//   num get priceSheets => _priceSheets;

//   void setStoreAndPrice({required String store, required num price}) {
//     selectedStoreName = store;
//     _priceSheets = price;
//     notifyListeners();
//   }

//   void selectDate(DateTime date) {
//     _selectedDate = date;
//     notifyListeners();
//   }

//   void selectTime(String time) {
//     _selectedTime.clear();
//     if (time.isNotEmpty) {
//       _selectedTime.add(time);
//       _selectedCountPerSlot!.update(
//         time,
//         (value) => value + 1,
//         ifAbsent: () => 1,
//       );
//     }
//     notifyListeners();
//   }

//   final List<Map<String, dynamic>> _bookings = [];
//   get bookings => _bookings;
//   void addBooking({
//     required String date,
//     required String time,
//   }) {
//     _bookings.add({
//       'date': date,
//       'time': time,
//     });
//     notifyListeners();
//   }
// }

// class StoreSelected extends ChangeNotifier {
//   String _selectedStore = '';
//   num _updatePrice = 0;

//   String get selectedStore => _selectedStore;
//   num get updatePrice => _updatePrice;

//   void setStoreAndPrice({required String store, required num price}) {
//     _selectedStore = store;
//     _updatePrice = price;
//     notifyListeners();
//   }
// }

// class StoreNameProvider extends ChangeNotifier {
//   String storeName;
//   num price;

//   StoreNameProvider({
//     this.storeName = "Lekin",
//      this.price = 55,
//   });

//   void addStore({
//     required String selectedStore,
//   }) {
//     storeName = selectedStore;
//     notifyListeners();
//   }
// }

// class StoreNameProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> _orders = [
 
//   ];
//     get orders => _orders;
//   void addOrder({
//     required String selectedStore ,
//     required num updatePrice,
//       }) {
//     _orders.add({
//       'no': '$selectedStore',
//       'price':'$updatePrice.',    
//           });
//     notifyListeners();
//   }
// }
 
// Future<int> getMaxAvailableTimeSlot() async {
//   DateTime now = DateTime.now();
//   int offset = await NTP.getNtpOffset(localTime: now);
//   DateTime syncTime = now.add(Duration(milliseconds: offset));
//   if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 7, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 8, 00))) {
//     return 1;
//   } 
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 8, 00)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 8, 30))) {
//     return 2;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 8, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 9, 0))) {
//     return 3;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 9, 0)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 9, 30))) {
//     return 4;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 9, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 10, 00))) {
//     return 5;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 10, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 11, 0))) {
//     return 6;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 11, 0)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 11, 30))) {
//     return 7;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 11, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 12, 0))) {
//     return 8;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 13, 0)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 13, 30))) {
//     return 9;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 13, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 14, 0))) {
//     return 9;
//   }
//    else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 14, 0)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 14, 30))) {
//     return 10;
//   }
//   else if (syncTime.isAfter(DateTime(now.year, now.month, now.day, 14, 30)) &&
//       syncTime.isBefore(DateTime(now.year, now.month, now.day, 15,0))) {
//     return 11;
//   }
// }
