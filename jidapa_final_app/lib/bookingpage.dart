import 'package:flutter/material.dart';
import 'package:jidapa_final_app/confirm.dart';

class BookingApp extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}
class _BookingScreenState extends State<BookingApp> {
      String? selectedTime;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Booking Movie'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            DateSelector(
            ),
            TimeSelector(),
            Location(),
            SeatSelector(),
             SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingListPage(
                        // selectedTime: selectedTime,
                        // selectedDate: selectedDate,
                      ),
                    ),
                  );
                },
                child: Text('Submit'),//link to confirmpage
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int dateIndexSelected = 1;
  DateTime currentDate = DateTime.now();
  String _dayFormat(int dayWeek) {
    switch (dayWeek) {
      case 2:
        return "TU";
      case 3:
        return "WE";
      case 4:
        return "TH";
      case 5:
        return "FR";
      case 6:
        return "SA";
      case 7:
        return "SU";
      default:
        return "MO";
    }
  }
  Color _getColor(int index) {
    return index == dateIndexSelected ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 13,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Container(
              width: size.width,
              child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var date = currentDate.add(Duration(days: index));
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        dateIndexSelected = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: 12,
                      ),
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              color: _getColor(index), 
                            ),
                          ),
                          Text(
                            _dayFormat(date.weekday),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getColor(index), 
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}
int timeIndexSelected = 1;
  Color _getColor(int index) {
    return index == timeIndexSelected ? Colors.blue : Colors.grey;
  }
class _TimeSelectorState extends State<TimeSelector> {
  int timeIndexSelected = 1;
  String? selectedTime;
  DateTime? selectedDate;
  var time = [
    ["01.30", 5],
    ["04.30", 10],
    ["08.30", 15]
  ];

  Widget _timeItem(String time, int price, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
          print('Selected time: $selectedTime');
        });
      },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 0.75),
      decoration: BoxDecoration(
        border: Border.all(
          color: active ? Colors.blue : Colors.white, 
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: time,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: active ? Colors.blue : Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' PM',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                   color: active ? Colors.blue : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 17,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.035),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: time.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: index == 0 ? 32 : 0),
              child: _timeItem(
                time[index][0] as String,
                (time[index][1] as num).toInt(),
                index == timeIndexSelected ,
              ),
            );
          },
        ),
      ),
    );
  }
}
class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color:Colors.white,
            size: 30,
            ),
          SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SFCinemas',style: TextStyle(
               color:Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),),
              Text('Bangkok',
              style: TextStyle(
                color:Colors.white,
                fontSize: 16.0,
              ),),
            ],
          )
        ],
      ),
    );
  }
}
class SeatSelector extends StatefulWidget {
  @override
  _SeatSelectorState createState() => _SeatSelectorState();
}
class _SeatSelectorState extends State<SeatSelector> {
  Widget _chairList(){
    Size size = MediaQuery.of(context).size;
    var _chairStatus = [
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 2, 1, 3, 1, 1],
      [3, 1, 2, 1, 1, 3, 2],
      [3, 3, 3, 1, 3, 1, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 3, 3, 1],
    ];
    return Container(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < 6; i++)
            Container(
              margin: EdgeInsets.only(top: i == 3 ? size.height * .02 : 0),
              child: Row(
                children: <Widget>[
                  for (int x = 0; x < 9; x++)
                    Expanded(
                      flex: x == 0 || x == 8 ? 2 : 1,
                      child: x == 0 ||
                          x == 8 ||
                          (i == 0 && x == 1) ||
                          (i == 0 && x == 7) ||
                          (x == 4)
                          ? Container()
                          : Container(
                        height: size.width / 11 - 10,
                        margin: EdgeInsets.all(5),
                        child: _chairStatus[i][x - 1] == 1
                            ? BuildChairs.availableChair()
                            : _chairStatus[i][x - 1] == 2
                            ? BuildChairs.selectedChair()
                            : BuildChairs.reservedChair(),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      flex: 47,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width,
          ),
          Positioned(
            top: 48,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                      ),
                    ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.55,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    width: 6.0,
                    color: Colors.white,
                  )
                  )
                 ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: size.height * .02,
              child: Container(width: size.width, 
              child: _chairList()
              )
              ),
        ],
      ),
    );
  }
}
class BuildChairs{
  static Widget selectedChair(){
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6.0)
      ),
    );
  }
  static Widget availableChair(){
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          border: Border.all(color:Colors.white),
          borderRadius: BorderRadius.circular(6.0)
      ),
    );
  }
  static Widget reservedChair(){
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(6.0)
      ),
    );
  }
}
class RequestModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _request = [
  ];
    get request => _request;
  void addOrder({
    required String userID,
    required String time,
    required String movieID,
      }) {
    _request.add({
      'userID': '$userID',
      'time':'$time',    
      'movieID':'$movieID',
    });
    notifyListeners();
  }
}
