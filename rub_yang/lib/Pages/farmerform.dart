import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FarmerForm extends StatefulWidget {
  const FarmerForm({Key? key}) : super(key: key);

  @override
  _FarmerInfState createState() => _FarmerInfState();
}

class _FarmerInfState extends State<FarmerForm> {
  String namefarmer = '';
  String lastnfarmer = '';
  String nationality = '';
  num areafarm = 0;
  num quantitytree = 0;
  num agetree = 0;
  String location = '';
  String telnum = '';
  late String selectedCountry;
  late String? selectedState;
  late String? selectedCity;
  bool isPhoneValidated = false;
  String _radioValue11 = '';
  String _radioValue12 = '';
  late CollectionReference _farmerDataCollection;
  late Future<FirebaseApp> _firebase;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _farmerDataCollection = FirebaseFirestore.instance.collection("farmerdata");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
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
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ชื่อชาวสวน',
                            prefixIcon: Icon(
                              Icons.people,
                              size: 28,
                              color: Colors.brown,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อ';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              namefarmer = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'นามสกุล',
                            prefixIcon: Icon(
                              Icons.people,
                              size: 28,
                              color: Colors.brown,
                            ),
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
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'สัญชาติ',
                            prefixIcon: Icon(
                              Icons.flag_circle,
                              size: 28,
                              color: Colors.brown,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกสัญชาติ';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              nationality = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ที่อยู่',
                            prefixIcon: Icon(
                              Icons.home,
                              size: 28,
                              color: Colors.brown,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกที่อยู่';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              location = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        CSCPicker(
                          onCountryChanged: (country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                          onStateChanged: (state) {
                            setState(() {
                              selectedState = state;
                            });
                          },
                          onCityChanged: (city) {
                            setState(() {
                              selectedCity = city;
                            });
                          },
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
                            setState(() {
                              telnum = phone.completeNumber ?? '';
                            });
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
                                      'ขนาดไร่ในสวนยาง(ไร่)',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.area_chart,
                                            size: 28,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'ขนาดไร่ในสวนยาง(ไร่)';
                                          }
                                          return null;
                                        },
                                        onSaved: (newValue) {
                                          setState(() {
                                            areafarm =
                                                num.parse(newValue!);
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
                                      'จำนวนต้นในสวนยาง(ต้น)',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.area_chart,
                                            size: 28,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'จำนวนต้นในสวนยาง';
                                          }
                                          return null;
                                        },
                                        onSaved: (newValue) {
                                          setState(
                                            () {
                                              quantitytree =
                                                  num.parse(newValue!);
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
                                      'จำนวนต้นอายุ>25ปีในสวน(ต้น)',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.area_chart,
                                            size: 28,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'จำนวนต้นที่อายุเกิน25ปีในสวนยาง';
                                          }
                                          return null;
                                        },
                                        onSaved: (newValue) {
                                          setState(
                                            () {
                                              agetree =
                                                  num.parse(newValue!);
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
                            Text(
                              'เป็นเจ้าของสวนยางพาราเองไหม',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              SizedBox(width: 10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 'เจ้าของสวน',
                                      groupValue: _radioValue12,
                                      onChanged: (value) {
                                        setState(() {
                                          _radioValue12 = value.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
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
                        const SizedBox(height: 30.0),
                        Text(
                          'สนใจเข้าร่วมโครงการยางเก่าของกยทไหม',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height:18),
                        Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      
                        SizedBox(height: 16),
                        ButtonTheme(
                          child: Container(
                            width: double.infinity,
                            color: Colors.brown[500],
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  formKey.currentState?.save();
                                  await _farmerDataCollection.add({
                                    'namefarmer': namefarmer,
                                    'lastnfarmer': lastnfarmer,
                                    'nationality': nationality,
                                    'areafarm': areafarm,
                                    'quantitytree': quantitytree,
                                    'agetree': agetree,
                                    'location': location,
                                    'selectedCountry': selectedCountry,
                                    'selectedState': selectedState,
                                    'selectedCity': selectedCity,
                                    'telnum ': telnum,
                                    '_radioValue11': _radioValue11,
                                    '_radioValue12': _radioValue12,
                                  });
                                  formKey.currentState?.reset();
                                }
                              },
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                                 ),
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// }
class FarmerData {
  // String id = "";
  String namefarmer = '';
  String lastnfarmer = '';
  String nationality = '';
  num areafarm = 0;
  num quantitytree = 0;
  num agetree = 0;
  String location = '';
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String telnum = '';
  String _radioValue11 = '';
  String _radioValue12 = '';
  FarmerData(
    // this.id,
    this.namefarmer,
    this.lastnfarmer,
    this.nationality,
    this.areafarm,
    this.quantitytree,
    this.agetree,
    this.location,
    this.selectedCountry,
    this.selectedState,
    this.selectedCity,
    this.telnum,
    this._radioValue11,
    this._radioValue12,
  );
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
