import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
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
  String nationality = '';
  num areafarm = 0;
  num quantitytree = 0;
  num agetree = 0;
  String location = '';
  String telnum = '';
  int count = 0;
  int count2 = 0;
  int count3 = 0;
  bool isPhoneValidated = false;
  String _radioValue11 = '';
  String _radioValue12 = '';

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
              child: CustomScrollView(slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(children: [
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
                                setState(
                                  () {
                                    namefarmer = newValue!;
                                  },
                                );
                              }),
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
                              setState(
                                () {
                                  lastnfarmer = newValue!;
                                },
                              );
                            },
                          ),
                        ),
                      ]),
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
                            setState(
                              () {
                                nationality = newValue!;
                              },
                            );
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
                        onCountryChanged: (country) {},
                        onStateChanged: (state) {},
                        onCityChanged: (city) {},
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ขนาดไร่ในสวนยาง',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // prefixIcon: Icon(Icons.person),
                                          ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'ขนาดไร่ในสวนยาง';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        setState(() {
                                          areafarm = num.parse(
                                              newValue!); // แปลงข้อมูลเป็นตัวเลข
                                        });
                                      },
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'จำนวนต้นในสวนยาง',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // prefixIcon: Icon(Icons.numbers_outlined),
                                          ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'จำนวนต้นในสวนยาง';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        setState(
                                          () {
                                         quantitytree = num.parse(
                                              newValue!); 
                                          },
                                        );
                                      },
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'จำนวนต้นที่อายุเกิน25ปีในสวนยาง',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          // prefixIcon: Icon(Icons.person),
                                          ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'จำนวนต้นที่อายุเกิน25ปีในสวนยาง';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        setState(
                                          () {
                                           agetree = num.parse(
                                              newValue!); 
                                          },
                                        );
                                      },
                                    ),
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
                            value: 'เข้าร่วม',
                            groupValue: _radioValue11,
                            onChanged: (value) {
                              setState(() {
                                _radioValue11 = value.toString();
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
                            value: 'ไม่เข้าร่วม',
                            groupValue: _radioValue11,
                            onChanged: (value) {
                              setState(() {
                                _radioValue11 = value.toString();
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
                            value: 'เจ้าของสวน',
                            groupValue: _radioValue12,
                            onChanged: (value) {
                              setState(() {
                                _radioValue12 = value.toString();
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
                            value: 'เป็นผู้แทน',
                            groupValue: _radioValue12,
                            onChanged: (value) {
                              setState(() {
                                _radioValue12 = value.toString();
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
                            value: 'มีหลักฐาน',
                            groupValue: _radioValue12,
                            onChanged: (value) {
                              setState(() {
                                _radioValue12 = value.toString();
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
                            value: 'ไม่มีหลักฐาน',
                            groupValue: _radioValue12,
                            onChanged: (value) {
                              setState(() {
                                _radioValue12 = value.toString();
                              });
                            },
                          ),
                          Text(
                            '4.เป็นแต่ไม่มีหลักฐานความยินยอม',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text(
                            //         'ราคา:$price_r \n น้ำหนัก: $weight_r \n วันที่จะมาส่ง: $date_r \n เวลาที่ส่ง: $time_r',
                            //       ),
                            //     ),
                            //   );

                            //   final farmerData = context.read<FarmerData>();
                            //   farmerData.addData(
                            //     no: '123',
                            //     price: '$price_r',
                            //     weight: '$weight_r',
                            //     date: ' $date_r',
                            //     time: '$time_r',
                            //   );
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // primary: Colors.brown,
                            elevation: 5,
                          ),
                          child: Text(
                            'บันทึก',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}

// class FarmerData extends ChangeNotifier {
//   final List<Map<String, dynamic>> _datas = [
//     {
//       'no': '10001',
//       'price': '48 บ.',
//       'weight': '50 กก',
//       'date': '12/10/2566',
//       'time': '12.00'
//     },
//     {
//       'no': '10002',
//       'price': '58 บ.',
//       'weight': '110 กก',
//       'date': '09/10/2566',
//       'time': '10.00'
//     },
//   ];
//   get datas => _datas;
//   void addOrder({
//     required String namefarmer,
//     required String lastnfarmer,
//     required String nationality,
//     required String date,
//     required String time,
//   }) {
//     _datas.add({
//       'no': '$no',
//       'price': '$price.',
//       'weight': '$weight',
//       'date': '$date',
//       'time': '$time'
//     });
//     notifyListeners();
//   }
// }
