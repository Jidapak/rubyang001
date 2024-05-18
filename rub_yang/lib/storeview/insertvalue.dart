import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class InsertValue extends StatefulWidget {
  @override
  _InsertValueState createState() => _InsertValueState();
}

class _InsertValueState extends State<InsertValue> {
  final formKey = GlobalKey<FormState>();
  late Price myPrice;
  late CollectionReference _pricesCollection;
  late Future<FirebaseApp> _firebase;

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _pricesCollection = FirebaseFirestore.instance.collection("centerprices");
    myPrice = Price(0, 0, 0, 0, 0, 0, 0, 0, 0, DateTime.now());
  super.initState();
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
                title: Text('อัพเดทราคากลางตามการยาง',
                 style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ExpansionTile(
                              title: Center(
                                child: Text(
                                  'ราคาแบบแผ่น',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'กรอกราคาปัจจุบัน (แบบแผ่น)',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกราคาปัจจุบัน (แบบแผ่น)';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    myPrice.daily_price_sheet =
                                        num.tryParse(value!) ?? 0;
                                  },
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'ราคาอัพเดท (แบบแผ่น)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'กรอกราคาที่อัพเดท (แบบแผ่น)',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกราคาที่อัพเดท (แบบแผ่น)';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    myPrice.update_price_sheet =
                                        num.tryParse(value!) ?? 0;
                                  },
                                ),
                              ]),
                          ExpansionTile(
                              title: Center(
                                child: Text(
                                  'ราคาแบบก้อน',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'กรอกราคาปัจจุบัน (แบบก้อน)',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกราคาปัจจุบัน (แบบก้อน)';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    myPrice.daily_price_chunk =
                                        num.tryParse(value!) ?? 0;
                                  },
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'ราคาอัพเดท (แบบก้อน)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'กรอกราคาที่อัพเดท (แบบก้อน)',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกราคาที่อัพเดท (แบบก้อน)';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    myPrice.update_price_chunk =
                                        num.tryParse(value!) ?? 0;
                                  },
                                ),
                              ]),
                          ExpansionTile(
                            title: Center(
                              child: Text(
                                'ราคาแบบน้ำ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'กรอกราคาปัจจุบัน (แบบน้ำ)',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกราคาปัจจุบัน (แบบน้ำ)';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  myPrice.daily_price_water =
                                      num.tryParse(value!) ?? 0;
                                },
                              ),
                              SizedBox(height: 16),
                              Text(
                                'ราคาอัพเดท (แบบน้ำ)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'กรอกราคาที่อัพเดท (แบบน้ำ)',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกราคาที่อัพเดท (แบบน้ำ)';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  myPrice.update_price_water =
                                      num.tryParse(value!) ?? 0;
                                },
                              ),
                            ]
                          ),
                              SizedBox(height: 16),
                              ButtonTheme(
                                minWidth: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      formKey.currentState?.save();
                                      myPrice.today_date = DateTime.now();
                                      myPrice.price_diff_sheet =
                                          myPrice.daily_price_sheet -
                                              myPrice.update_price_sheet;
                                      myPrice.price_diff_chunk =
                                          myPrice.daily_price_chunk -
                                              myPrice.update_price_chunk;
                                      myPrice.price_diff_water =
                                          myPrice.daily_price_water -
                                              myPrice.update_price_water;
                                      await _pricesCollection.add({
                                        "daily_price_sheet":
                                            myPrice.daily_price_sheet,
                                        "update_price_sheet":
                                            myPrice.update_price_sheet,
                                        "price_diff_sheet":
                                            myPrice.price_diff_sheet,
                                        "daily_price_chunk":
                                            myPrice.daily_price_chunk,
                                        "update_price_chunk":
                                            myPrice.update_price_chunk,
                                        "price_diff_chunk":
                                            myPrice.price_diff_chunk,
                                        "daily_price_water":
                                            myPrice.daily_price_water,
                                        "update_price_water":
                                            myPrice.update_price_water,
                                        "price_diff_water":
                                            myPrice.price_diff_water,
                                        "today_date": myPrice.today_date,
                                      });
                                      formKey.currentState?.reset();
                                    }
                                  },
                                  child: Text('บันทึก'),
                                ),
                              ),
                            ],
                     ),
                  ),
                ),
              ));
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
  num daily_price_sheet;
  num update_price_sheet;
  num price_diff_sheet;
  num daily_price_chunk;
  num update_price_chunk;
  num price_diff_chunk;
  num daily_price_water;
  num update_price_water;
  num price_diff_water;
  late DateTime today_date;

  Price(
    this.daily_price_sheet,
    this.update_price_sheet,
    this.price_diff_sheet,
    this.daily_price_chunk,
    this.update_price_chunk,
    this.price_diff_chunk,
    this.daily_price_water,
    this.update_price_water,
    this.price_diff_water,
    this.today_date,
  );
}
