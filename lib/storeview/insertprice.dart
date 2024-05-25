import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class InsertPrice extends StatefulWidget {
  @override
  _InsertPriceState createState() => _InsertPriceState();
}

class _InsertPriceState extends State<InsertPrice> {
  final formKey = GlobalKey<FormState>();
  late Price myPrice;
  late CollectionReference _pricesCollection;
  late Future<FirebaseApp> _firebase;
final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _pricesCollection = FirebaseFirestore.instance.collection("prices");
    myPrice = Price(
      // "",
      "",
      "",
      "",
      0,
      0,
      0,
      DateTime.now(),
      0,
      0,
      0,
      0,
      0,
      0,
    );
  }
@override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get the current user
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
                'อัพเดทราคา',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    user?.email ?? '', 
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // SizedBox(height: 10),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     labelText: 'IDร้านรับซื้อ',
                      //   ),
                      //   validator:
                      //       RequiredValidator(errorText: "กรุณากรอก ID ร้าน"),
                      //   onSaved: (String? id_store) {
                      //     myPrice.id_store = id_store;
                      //   },
                      // ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ชื่อร้านรับซื้อ',
                        ),
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกชื่อร้าน"),
                        onSaved: (String? name_store) {
                          myPrice.name_store = name_store;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'อำเภอ',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาอำเภอ"),
                        onSaved: (String? district) {
                          myPrice.district = district;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'เบอร์ติดต่อร้าน',
                        ),
                        validator: (telnum) {
                          if (telnum == null || telnum.isEmpty) {
                            return 'กรุณากรอกเบอร์ติดต่อร้าน';
                          }
                          // // เช็ครูปแบบเบอร์โทรศัพท์
                          // RegExp regex = RegExp(
                          //     r'^[0-9]{10}$'); // ตรวจสอบเบอร์โทรศัพท์ที่มี 10 ตัวเลข
                          // if (!regex.hasMatch(telnum)) {
                          //   return 'เบอร์ติดต่อร้านไม่ถูกต้อง';
                          // }
                          // return null;
                        },
                        onSaved: (telnum) {
                          myPrice.telnum = telnum;
                        },
                      ),
                      Card(
                        child: ExpansionTile(
                          title: Text('ราคาแบบแผ่น'),
                          children: [
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคายางแบบแผ่น(เมื่อวาน)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคายางแบบแผ่น';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.daily_pricesheet =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคายางแผ่นอัพเดท(วันนี้)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคาที่อัพเดทยางแผ่น';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.update_pricesheet =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: ExpansionTile(
                          title: Text('ราคาแบบก้อน'),
                          children: [
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคาแบบก้อน(เมื่อวาน)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคายางแบบก้อน';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.daily_pricechunk =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคายางก้อนอัพเดท(วันนี้)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคาที่อัพเดทยางก้อน';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.update_pricechunk =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: ExpansionTile(
                          title: Text('ราคายางแบบน้ำ'),
                          children: [
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคายางแบบน้ำ(เมื่อวาน)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคายางแบบน้ำ';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.daily_pricewater =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'ราคายางน้ำอัพเดท(วันนี้)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกราคาที่อัพเดทยางน้ำ';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                myPrice.update_pricewater =
                                    num.tryParse(value!) ?? 0;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            myPrice.today_date = DateTime.now();
                            myPrice.pricsheet_diff = myPrice.update_pricesheet -
                                myPrice.daily_pricesheet;
                            myPrice.pricwater_diff = myPrice.update_pricewater -
                                myPrice.daily_pricewater;
                            myPrice.pricchunk_diff = myPrice.update_pricechunk -
                                myPrice.daily_pricechunk;
                            await _pricesCollection.add({
                              // "id_store": myPrice.id_store,
                              "name_store": myPrice.name_store,
                              "district": myPrice.district,
                              "telnum": myPrice.telnum,
                              "daily_pricesheet": myPrice.daily_pricesheet,
                              "daily_pricewater": myPrice.daily_pricewater,
                              "daily_pricechunk": myPrice.daily_pricechunk,
                              "update_pricesheet": myPrice.update_pricesheet,
                              "update_pricewater": myPrice.update_pricewater,
                              "update_pricechunk": myPrice.update_pricechunk,
                              "pricwater_diff": myPrice.pricwater_diff,
                              "pricsheet_diff": myPrice.pricsheet_diff,
                              "pricchunk_diff": myPrice.pricchunk_diff,
                              "today_date": myPrice.today_date,
                            });
                            formKey.currentState?.reset();
                          }
                        },
                        child: Text('บันทึก'),
                      ),
                    ],
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

class Price {
  // String? id_store;
  String? name_store;
  String? district;
  String? telnum;
  num daily_pricesheet;
  num daily_pricewater;
  num daily_pricechunk;
  num update_pricesheet;
  num update_pricewater;
  num update_pricechunk;
  num pricchunk_diff;
  num pricsheet_diff;
  num pricwater_diff;
  late DateTime today_date;
  Price(
    // this.id_store,
    this.name_store,
    this.telnum,
    this.district,
    this.daily_pricesheet,
    this.daily_pricewater,
    this.daily_pricechunk,
    this.today_date,
    this.update_pricesheet,
    this.update_pricewater,
    this.update_pricechunk,
    this.pricchunk_diff,
    this.pricsheet_diff,
    this.pricwater_diff,
  );
}
