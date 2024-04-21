import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class List_form extends StatefulWidget {
  @override
  State<List_form> createState() => _ListTradeState();
}

class _ListTradeState extends State<List_form> {
  final _formKey = GlobalKey<FormState>();

  String price_r = '';
  String weight_r= '';
  String date_r = '';
  String time_r = '';
  
  @override
  Widget build(BuildContext context) {
     final dropdownProvider = context.watch<DropdownProvider>();
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
                      'คำสั่งรับยาง',
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ราคา',
                      hintText: 'ราคา',
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'วันที่ส่ง',
                      hintText: 'วันที่ส่ง',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกวันเดือนปีที่จะมาส่ง.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      date_r = newValue!;
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
                      labelText: 'เวลาส่ง',
                      hintText: 'เวลาส่ง',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกเวลาที่จะมาส่ง';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      time_r = newValue!;
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
                              'ราคา:$price_r \n น้ำหนัก: $weight_r \n วันที่จะมาส่ง: $date_r \n เวลาที่ส่ง: $time_r',
                            ),
                          ),
                        );
                         final orderRequestModel =
                            context.read<OrderRequestModel>();
                        orderRequestModel.addOrder(
                          no: '123',
                          price: '$price_r',
                          weight: '$weight_r',
                          date: ' $date_r',
                          time: '$time_r',
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
                ), 
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
      'price': '48 บ.',
      'weight': '50 กก',
      'date': '12/10/2566',
      'time': '12.00'
    },
    {
      'no': '10002',
      'price': '58 บ.',
      'weight': '110 กก',
      'date': '09/10/2566',
      'time': '10.00'
    },
  ];
    get orders => _orders;
  void addOrder({
    required String no,
    required String price,
    required String weight,
    required String date,
    required String time,
  }) {
    _orders.add({
      'no': '$no',
      'price':'$price.',    
      'weight':'$weight',
      'date':'$date',
      'time':'$time'
    });
    notifyListeners();
  }
}
class DropdownProvider extends ChangeNotifier {
  String selectedProduct = 'แบบก้อน';
  String selectedTradingType = 'ซื้อขายล่วงหน้า';

  void setProduct(String product) {
    selectedProduct = product;
    notifyListeners();
  }

  void setTradingType(String tradingType) {
    selectedTradingType = tradingType;
    notifyListeners();
  }
}