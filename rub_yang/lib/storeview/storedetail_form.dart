import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Form_Store extends StatefulWidget {
  @override
  _MyFormStorePageState createState() => _MyFormStorePageState();
}

class _MyFormStorePageState extends State<Form_Store> {
  final formKey = GlobalKey<FormState>();
  Store myStore = Store("","", "", "", "", "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _storeCollection =FirebaseFirestore.instance.collection("store"); 
  //เตรียมfirebase
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
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
                title: Text('รายละเอียดร้านค้า'),
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
                          'IDร้าน',
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
                              RequiredValidator(errorText: "กรุณากรอกIDร้าน"),
                          onSaved: (String? id_store) {
                            myStore.id_store = id_store;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ชื่อร้าน',
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
                          onSaved: (String? namestore) {
                            myStore.namestore = namestore;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'ตำบล',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกตำบล',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกตำบล"),
                          onSaved: (String? subdistrict) {
                            myStore.subdistrict = subdistrict;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'อำเภอ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกอำเภอ',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกอำเภอ"),
                          onSaved: (String? district) {
                            myStore.district = district;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'จังหวัด',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกจังหวัด',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกจังหวัด"),
                          onSaved: (String? province) {
                            myStore.province = province;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'เบอร์โทร',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'กรอกเบอร์โทร',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          initialCountryCode: 'TH',
                          onSaved: (phone) {
                            if (phone != null) {
                              myStore.telnum = phone.completeNumber!;
                            }
                          },
                          validator: (phone) {
                            if (phone == null ||
                                phone.completeNumber == null ||
                                phone.completeNumber!.isEmpty) {
                              return 'กรุณากรอกเบอร์โทร';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (formKey.currentState?.validate() ?? false) {
                                formKey.currentState?.save();
                               await _storeCollection.add({
                                "id_stored":myStore.id_store,
                                  "namestore": myStore.namestore,
                                  "subdistrict": myStore.subdistrict,
                                  "district": myStore.district,
                                  "province": myStore.province,
                                  "telnum": myStore.telnum
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
        });
    //
  }
}
class Store {
  String? id_store ;
  String? namestore;
  String? subdistrict;
  String? district;
  String? province;
  String? telnum;
  Store(
    this.id_store,
    this.namestore,
    this.subdistrict,
    this.district,
    this.province,
    this.telnum,
  );
}