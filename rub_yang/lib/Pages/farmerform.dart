import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class FarmerForm extends StatefulWidget {
  const FarmerForm({Key? key}) : super(key: key);

  @override
  State<FarmerForm> createState() => _FarmerInfState();
}
class _FarmerInfState extends State<FarmerForm> {
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
  int _radioValue11 = 0;
  int _radioValue12 = 0;
  int _radioValue21 = 0;
  int _radioValue22 = 0;
  int _radioValue23 = 0;
  int _radioValue24 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลของชาวสวนยาง',
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
      body: Padding(
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
                              labelText: 'ชื่อ',
                              hintText: 'กรอกชื่อ',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกชื่อ';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              namefarmer = newValue!;
                            },
                          ),
                        ),
                       const SizedBox(width: 10.0),
                        Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'นามสกุล',
                          hintText: 'กรอกนามสกุล',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกนามสกุล';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          lastnfarmer = newValue!;
                        },
                      ),
                    ),
                  ]
                  ),
                    const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'สัญชาติ',
                              prefixIcon: Icon(Icons.flag_circle),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกสัญชาติ';
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
                              labelText: 'ที่อยู่',
                              prefixIcon: Icon(Icons.home),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกที่อยู่';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              location = newValue!;
                            },
                          ),
                        ),          
              const SizedBox(height: 10.0),
              CSCPicker( 
                //Locationaddress
                onCountryChanged: (country){},
                onStateChanged: (state){},
                onCityChanged: (city){},
                countryFilter: [CscCountry.Thailand],
              ),
              const SizedBox(height: 10.0),
              IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'เบอร์โทร',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                     initialCountryCode: 'TH',
                      onChanged: (phone) {
                        print(phone.completeNumber); 
                      },
                                    validator: (value) {
                      if (value!.isValidNumber()) {
                        setState(() {
                            isPhoneValidated = true;
                        });
                      } else {
                        setState(() {
                            isPhoneValidated = false;
                        });
                      }
                      return null;
                    },
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
                        'ขนาดไร่ในสวนยาง',
                        style: TextStyle(
                          fontSize: 16.0,
                         color: Colors.black,
                        ),
                      ),
                      ElegantNumberButton(
                        initialValue: count,
                        minValue: 0,
                        maxValue: 200,
                        onChanged: (value) {
                          setState(() {
                            count = value.toInt();
                          });
                        },
                        decimalPlaces: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                        'จำนวนต้นในสวนยาง',
                        style: TextStyle(
                         color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      ElegantNumberButton(
                        initialValue: count2,
                        minValue: 0,
                        maxValue: 200,
                        onChanged: (value) {
                          setState(() {
                            count2 = value.toInt();
                          });
                        },
                        decimalPlaces: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                        'จำนวนต้นที่อายุเกิน20ปีในสวนยาง',
                        style: TextStyle(
                          fontSize: 16.0,
                         color: Colors.black,
                        ),
                      ),
                      ElegantNumberButton(
                        initialValue: count3,
                        minValue: 0,
                        maxValue: 200,
                        onChanged: (value) {
                          setState(() {
                            count3 = value.toInt();
                          });
                        },
                        decimalPlaces: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
                const SizedBox(height: 20.0),
                    Text(
                        'สนใจเข้าร่วมโครงการยางเก่าของกยทไหม',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ), 
                    Row(
                    children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue11,
                      onChanged: (value) {
                        setState(() {
                          _radioValue11 = value as int;
                        });
                      },
                    ),
                    Text(
                          'เข้าร่วมโครงการ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ), 
                    Radio(
                      value: 1,
                      groupValue: _radioValue12,
                      onChanged: (value) {
                        setState(() {
                          _radioValue12 = value as int;
                        });
                      },
                    ),
                    Text(
                          'ไม่เข้าร่วมโครงการ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ), 
                  ],
                ),
                const SizedBox(height: 20.0),
                    Text(
                        'เป็นเจ้าของสวนยางพาราเองไหม',
                        style: TextStyle(
                          fontSize: 16,
                         color: Colors.black, 
                          fontWeight: FontWeight.bold,
                        ),
                      ), 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue21,
                      onChanged: (value) {
                        setState(() {
                          _radioValue21 = value as int;
                        });
                      },
                    ),
                    Text(
                          '1.เป็นเจ้าของสวน',
                          style: TextStyle(
                            fontSize: 16,
                           color: Colors.black,
                          ),
                        ), 
                      Radio(
                      value: 1,
                      groupValue: _radioValue22,
                      onChanged: (value) {
                        setState(() {
                          _radioValue22 = value as int;
                        });
                      },
                    ),
                    Text(
                          '2.เป็นผู้แทนโดยชอบธรรม',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),     
                    Radio(
                      value: 0,
                      groupValue: _radioValue23,
                      onChanged: (value) {
                        setState(() {
                          _radioValue23 = value as int;
                        });
                      },
                    ),
                    Text(
                          '3.เป็นและมีหลักฐานความยินยอม',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ), 
                    Radio(
                      value: 1,
                      groupValue: _radioValue24,
                      onChanged: (value) {
                        setState(() {
                          _radioValue24 = value as int;
                        });
                      },
                    ),
                    Text(
                          '4.เป็นและไม่หลักฐานความยินยอม',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ), 
                  ],
                ),
                const SizedBox(height: 20.0),
               Container(
                color: Colors.transparent,
                height: 70,
                width: 500,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                onPressed: () { },
                child: Text(
                  'บันทึก',
                    style : TextStyle(
                    fontSize: 18, 
                   ),
                  ),
                style: ElevatedButton.styleFrom(
                side: 
                BorderSide(
                  width:6, 
                  color: Colors.brown,
                  ),
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
       );
     }
    }
