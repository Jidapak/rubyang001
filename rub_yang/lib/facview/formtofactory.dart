import 'package:flutter/material.dart';
// import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

class formfactory extends StatefulWidget{
  const formfactory({Key? key}) : super(key: key);
  @override
  State<formfactory> createState() => _formfactoryState();
}
class _formfactoryState extends State<formfactory> {
  final _formKey = GlobalKey<FormState>();
  String namefarmer = '';
  String lastnfarmer = '';
  String areafarm = '';
  String quantitytree = '';
  String agetree = '';
  String location = '';
  num telnum = 1;
  int count = 0;
  int count2 = 0;
  int count3 = 0;
  bool isPhoneValidated = false;

  String _radioValue12 = '';
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ฟอร์มส่งโรงงาน',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        height: 1000,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'ชื่อโรงงาน',
                              hintText: 'กรอกชื่อชื่อโรงงานที่ไปส่ง',
                              prefixIcon: Icon(Icons.factory),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกชื่อโรงงาน';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                              namefarmer = newValue!;
                            },
                           );
                            }
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                        child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'คุณภาพยาง',
                          hintText: 'กรอกนามสกุล',
                          prefixIcon: Icon(Icons.percent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกนามสกุล';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                            setState(() {
                          lastnfarmer = newValue!;
                        },
                        );
                       },
                      ),
                    ),
                  ]
                  ),
                const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'ยอดเงินรวม',
                              prefixIcon: Icon(Icons.money),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกยอดเงินรวม';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              location = newValue!;
                            },
                          ),
                        ), 
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'จำนวนรวมกิโลกรัม',
                              prefixIcon: Icon(Icons.monitor_weight),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาจำนวนรวม';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                              location = newValue!;
                            },
                              );
                            },
                          ),
                        ),
         const SizedBox(height: 10.0),
           Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'จำนวนรอบที่ส่งโรงงาน',
                        style: TextStyle(
                         color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      // ElegantNumberButton(
                      //   initialValue: count2,
                      //   minValue: 0,
                      //   maxValue: 200,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       count2 = value.toInt();
                      //     });
                      //   },
                      //   decimalPlaces: 0,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
                const SizedBox(height: 20.0),
                    Text(
                        'รูปแบบยางพาราที่นำไปขาย',
                        style: TextStyle(
                          fontSize: 16,
                         color: Colors.black, 
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    
                    Text(
                          '1.รูปแบบยางน้ำ',
                          style: TextStyle(
                            fontSize: 16,
                           color: Colors.black,
                          ),
                        ), 
                        Radio(
                      value: '',
                      groupValue: _radioValue12,
                      onChanged: (value) {
                        setState(() {
                          _radioValue12 = value.toString();
                        });
                      },
                    ),
                     
                    Text(
                          '2.รูปแบบยางแผ่น',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),     
                         Radio(
                      value: 'รูปแบบยางน้ำ',
                      groupValue: _radioValue12,
                      onChanged: (value) {
                        setState(() {
                          _radioValue12 = value.toString();
                        });
                      },
                    ),                 
                    Text(
                          '3.รูปแบบยางก้อน',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),  
                         Radio(
                      value: 'รูปแบบยางแผ่น',
                      groupValue: _radioValue12,
                      onChanged: (value) {
                        setState(() {
                          _radioValue12 = value.toString();
                        });
                      },
                    ),
                  ],
                ),
               Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    Navigator.pushNamed(context, '/fachistory');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
               ],
              ),
             ),
            ]
           ),
          ),
         ),
        ),
       );
     }
}
