import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class List_trade extends StatefulWidget {
  @override
  State<List_trade> createState() => _ListTradeState();
}
class _ListTradeState extends State<List_trade> {
  final _formKey = GlobalKey<FormState>();
  String price_r = '';
  String weight_r= '';
  String date_r = '';
  String time_r = '';

  String? selectedTime;
   List<String> timeOptions = [
    '08.30 น.',
    '09.00 น.',
    '09.30 น.',
    '10.00 น.',
    '10.30 น.',
    '11.00 น.',
    '11.30 น.',
    '12.00 น.',
    '13.00 น.',
    '13.30 น.',
    '14.00 น.',
    '14.30 น.',
    '15.00 น.',
    '15.30 น.',
    '16.00 น.',
    '16.30 น.',
    '17.00 น.',
  ];
  List<String> dropdownproduct = [
    'แบบก้อน',
    'แบบน้ำ',
    'แบบแผ่น',
  ];
  List<String> dropdownspotf=[
   'ซื้อขายล่วงหน้า',
   'ซื้อขายทันที',
  ];

  TextEditingController dateController = TextEditingController();
  String selectedDropdownValue = 'แบบก้อน' ;
  String selectedDropdownValue2 = 'ซื้อขายล่วงหน้า';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('รายการรับยาง'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.brown,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'ใบส่งคำขอเสนอราคายางพารา',
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.brown,
                  height: 2,
                  thickness: 3,
                  indent: 16,
                  endIndent: 16,
                ),
              Row(
                children: [
                  SizedBox(width: 20),
                Padding(
                padding: const EdgeInsets.only(right: 30.0), 
                child:Text(
                'ประเภทยางพารา:', 
                 style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                DropdownButton<String>(
                value:selectedDropdownValue,
                items: dropdownproduct.map((String item) {
                return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
                   );
                }
              )
               .toList(),
                onChanged: (newValue) {
                setState(() {
                selectedDropdownValue = newValue!;
              });
            },
          ),
        ],
      ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                    Padding(
                    padding: const EdgeInsets.only(right: 30.0), 
                    child:Text(
                    'ประเภทการซื้อขาย:', 
                    style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                       ),
                    ),
                  ),
                DropdownButton<String>(
                value:selectedDropdownValue2,
                items: dropdownspotf.map((String item) {
                return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
                );
              }
            ).toList(),
                  onChanged: (newValue) {
               setState(() {
               selectedDropdownValue2 = newValue!;
              });
             },
             ),
           ],
         ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ราคา',
                      hintText: 'ราคา',
                      labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกราคาตามช่วงราคาในวันนัั้น';
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      price_r = newValue!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'น้ำหนัก',
                      hintText: 'น้ำหนัก',
                      labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกน้ำหนักหน่วยกิโลกรัม';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      weight_r = newValue!;
                    },
                  ),
                ),
                Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Date:',
                    labelStyle:TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาระบุวันที่';
                    }
                    return null;
                  },
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                      setState(() {
                        date_r = formattedDate;
                        dateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
                Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'เวลาส่ง',
                    hintText: 'เลือกเวลาส่ง',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedTime, 
                  items: timeOptions.map((time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาเลือกเวลาที่จะมาส่ง';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      selectedTime = newValue;
                    });
                  },
                ),
              ),
                Padding( 
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'ราคา:$price_r บาท \n น้ำหนัก: $weight_r  กิโลกรัม \n วันที่จะมาส่ง: $date_r \n เวลาที่ส่ง: $selectedTime \n รูปแบบ: $dropdownproduct \n รูแบบการซื้อขาย: $dropdownspotf ',
                            ),
                          ),
                        );
                        final orderRequestModel =
                        Provider.of<OrderRequestModel>(context, listen: false);
                       orderRequestModel.addOrder(no:'123',price:'$price_r',weight:'$weight_r',date:' $date_r',time:'$selectedTime',dropdownproduct:'$dropdownproduct',dropdownspotf:'$dropdownspotf'
                       );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(300, 50),
                    ),
                    child: Text(
                      'ส่งข้อมูล',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class OrderRequestModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [
     {
      'no': '10001',
      'price':'48บ.',    
      'weight': '50กก',
      'date':'12/10/2566',
      'time':'12.00'
    },
     {
      'no': '10002',
      'price':'45บ.',    
      'weight':'50กก',
      'date':'12/08/2566',
      'time':'10.00'
    },
  ];
    get orders => _orders;

  void addOrder({
    required String no,
    required String price,
    required String weight,
    required String date,
    required String time,
    required String dropdownproduct,
    required String dropdownspotf,
      }) {
    _orders.add({
      'no': '$no',
      'price':'$price.',    
      'weight':'$weight',
      'date':'$date',
      'time':'$time',
      'typeproduct':'$dropdownproduct',
      'typetrade':'$dropdownspotf',
          });
    notifyListeners();
  }
}

