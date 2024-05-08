import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormKanyang extends StatefulWidget {
  @override
  _FormKanyangState createState() => _FormKanyangState();
}

class _FormKanyangState extends State<FormKanyang> {
  final formKey = GlobalKey<FormState>();
  late kanyang myKanyang;
  late CollectionReference _kanyangCollection;
  late Future<FirebaseApp> _firebase;
  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _kanyangCollection = FirebaseFirestore.instance.collection("kanyang");
    myKanyang = kanyang(
      "",
      "",
      "",
      "",
      DateTime.now(),
      "",
      "",
    );
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ชื่อร้านรับซื้อ',
                        ),
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกชื่อร้าน"),
                        onSaved: (String? namekanyang) {
                           myKanyang.namekanyang = namekanyang;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'อำเภอ',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาอำเภอ"),
                        onSaved: (String? district) {
                           myKanyang.district = district;
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
                          // เช็ครูปแบบเบอร์โทรศัพท์
                          RegExp regex = RegExp(
                              r'^[0-9]{10}$'); // ตรวจสอบเบอร์โทรศัพท์ที่มี 10 ตัวเลข
                          if (!regex.hasMatch(telnum)) {
                            return 'เบอร์ติดต่อร้านไม่ถูกต้อง';
                          }
                          return null;
                        },
                        onSaved: (telnum) {
                          myKanyang.telnum = telnum;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            await _kanyangCollection.add({
                              "name_kanyang": myKanyang.namekanyang,
                              "district": myKanyang.district,
                              "telnum": myKanyang.telnum,
                              "today_date": myKanyang.today_date,
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

class kanyang {
  String? namekanyang;
  String? road;
  String? district;
  String? telnum;
  String? campian;
  String? updatenew;
  late DateTime today_date;
  kanyang(
    this.namekanyang,
    this.telnum,
    this.road,
    this.district,
    this.today_date,
    this.campian,
     this.updatenew,
  );
}
