import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/storeview/confirmbk.dart';

const List<String> TIME_SLOT = [
  '07:30 AM',
  '08:00 AM',
  '08:30 AM',
  '09:00 AM',
  '09:30 AM',
  '10:00 AM',
  '10:30 AM',
  '11:00 AM',
  '11:30 AM',
  '12:00 PM',
  '01:00 PM',
  '01:30 PM',
  '02:00 PM',
  '02:30 PM',
  '03:00 PM',
  '03:30 PM',
  '04:00 PM'
];

class TimeSlot extends StatelessWidget {
  final String storeName;
  final num dailyPrice;
  TimeSlot({required this.storeName, required this.dailyPrice});
  @override
  Widget build(BuildContext context) {
    final selectedDate =
        Provider.of<SelectedDateTimeProvider>(context).selectedDate;
    final selectedTime =
        Provider.of<SelectedDateTimeProvider>(context).selectedTime;
    // final selectedStore =
    //     Provider.of<SelectedDateTimeProvider>(context)._selectedStore;
    // final updatePrice =
    //     Provider.of<SelectedDateTimeProvider>(context).updatePrice;
    final selectedTimeProvider =
        Provider.of<SelectedDateTimeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตารางเวลานำยางมาขาย',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'ร้านรับซื้อที่เลือก : $storeName',
            style: TextStyle(
              color: Colors.brown[800],
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'ราคา: $dailyPrice',
            style: TextStyle(color: Colors.brown[800], fontSize: 18),
          ),
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
                            'วันที่: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
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
                IconButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                    if (selectedDate != null) {
                      selectedTimeProvider.selectDate(selectedDate);
                    }
                    print('Selected Store: $storeName');
                    print('Update Price: $dailyPrice');
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
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
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (!selectedTime.contains(TIME_SLOT[index])) {
                    selectedTimeProvider.selectTime(TIME_SLOT[index]);
                  } else {
                    selectedTimeProvider.selectTime('');
                  }
                },
                child: Card(
                  color: selectedTime.contains(TIME_SLOT[index])
                      ? Colors.white10
                      : (selectedTime.isNotEmpty &&
                              selectedTime[0] == TIME_SLOT[index]
                          ? Colors.white54
                          : Colors.white),
                  child: GridTile(
                    header: selectedTime.isNotEmpty &&
                            selectedTime[0] == TIME_SLOT[index]
                        ? Icon(Icons.check)
                        : null,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${TIME_SLOT[index]}'),
                          Text(selectedTime.contains(TIME_SLOT[index])
                              ? (selectedTimeProvider.selectedCountPerSlot?[
                                              TIME_SLOT[index]] !=
                                          null &&
                                      (selectedTimeProvider
                                                      .selectedCountPerSlot?[
                                                  TIME_SLOT[index]] ??
                                              0) >
                                          6
                                  ? 'Full (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})'
                                  : 'Available (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})')
                              : 'Available (${selectedTimeProvider.selectedCountPerSlot![TIME_SLOT[index]]})')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final selectedDateTimeProvider =
                  Provider.of<SelectedDateTimeProvider>(context, listen: false);
              final selectedDate = selectedDateTimeProvider.selectedDate;
              final selectedTime =
                  selectedDateTimeProvider.selectedTime.isNotEmpty
                      ? selectedDateTimeProvider.selectedTime[0]
                      : '';
              if (selectedTime.isNotEmpty) {
                final formattedDate =
                    DateFormat('dd/MM/yyyy').format(selectedDate);

                // Show snackbar and navigate to ConfirmBK page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'วันที่จะมาส่ง: $formattedDate\nเวลาที่ส่ง: $selectedTime\nร้าน: $storeName\nราคา: $dailyPrice',
                    ),
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmBK(
                    storeName: storeName,
                      dailyPrice: dailyPrice,
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
            },
            child: Text('ส่งข้อมูล'),
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
  DateTime get selectedDate => _selectedDate;
  List<String> get selectedTime => _selectedTime;
  Map<String, int>? get selectedCountPerSlot => _selectedCountPerSlot;

  String _storeName = '';
  num _dailyPrice = 0;
  String get storeName => _storeName;
  num get dailyPrice => _dailyPrice;

  void setStoreAndPrice({required String store, required num price}) {
    _storeName = store;
    _dailyPrice = price;
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

  final List<Map<String, dynamic>> _bookings = [];
  get bookings => _bookings;
  void addBooking({
    required String date,
    required String time,
  }) {
    _bookings.add({
      'date': date,
      'time': time,
    });
    notifyListeners();
  }
}

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




// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:im_stepper/stepper.dart';

// class Bookingpage extends ConsumerWidget{
//   final currentStep = StateProvider((ref) => 1);
//   final userToken = StateProvider((ref) =>'');
//   final forceReload =StateProvider((ref) => '');

// @override
//  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef ref parameter
//     var step = ref.watch(currentStep);
//   // var cityWatch =watch(selectedCity).state;
//   return SafeArea(
//     child:Scaffold(
//     resizeToAvoidBottomInset: true,
//     backgroundColor: Colors.brown,
//     body: Column(
//      children: [
//       NumberStepper(
//         activeStep:step-1,
//         direction: Axis.horizontal,
//         enableNextPreviousButtons: false,
//         enableStepTapping: false,
//         numbers: [1,2,3,4,5],
//         stepColor: Colors.black,
//         activeStepColor: Colors.grey,
//         numberStyle: TextStyle(color: Colors.white),
//       )
//      ],
//     ),
//     ),
// );
// }
// }
