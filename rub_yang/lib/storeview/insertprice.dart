import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _pricesCollection = FirebaseFirestore.instance.collection("prices");
    myPrice = Price("","",0, 0, 0 ,DateTime.now());
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
              title: Text('อัพเดทราคา'),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                        Text(
                          'IDร้านรับซื้อ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกIDร้าน',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกชื่อร้าน"),
                          onSaved: (String? id_store) {
                            myPrice.id_store = id_store;
                          },
                        ),
                      SizedBox(height: 10),
                        Text(
                          'ชื่อร้านรับซื้อ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกชื่อร้าน',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกชื่อร้าน"),
                          onSaved: (String? name_store) {
                            myPrice.name_store = name_store;
                          },
                        ),
                      SizedBox(height: 10),
                      Text(
                        'ราคาปัจจุบัน',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'กรอกราคาปัจจุบัน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกราคาปัจจุบัน';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          myPrice.daily_price = num.tryParse(value!) ?? 0;
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'ราคาอัพเดท',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'กรอกราคาที่อัพเดท',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกราคาที่อัพเดท';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          myPrice.update_price = num.tryParse(value!) ?? 0;
                        },
                      ),
                      SizedBox(height: 16),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              formKey.currentState?.save();
                              myPrice.today_date = DateTime.now();//เวลาวันที่กรอก
                              myPrice.price_diff = myPrice.daily_price - myPrice.update_price;
                              await _pricesCollection.add({
                                "id_store":myPrice.id_store,
                                "name_store":myPrice.name_store,
                                "daily_price": myPrice.daily_price,
                                "update_price": myPrice.update_price,
                                 "price_difference": myPrice.price_diff,
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
  String? id_store ;
  String? name_store;
  num daily_price;
  num update_price;
  num price_diff;
  late DateTime today_date;

  Price(
    this.id_store,
    this.name_store,
    this.daily_price,
    this.update_price,
    this.price_diff,
    this.today_date,
  );
}
