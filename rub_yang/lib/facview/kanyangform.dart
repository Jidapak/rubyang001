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
              title: Text('รายละเอียดกยท',
              style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
              ),
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
                          labelText: 'กยทอำเภอ',
                        ),
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกชื่อกยทอำเภอ"),
                        onSaved: (String? namekanyang) {
                           myKanyang.namekanyang = namekanyang;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ถนน',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาถนน"),
                        onSaved: (String? road) {
                           myKanyang.road = road;
                        },
                      ),
                       SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ตำบล',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาตำบล"),
                        onSaved: (String? Subdistrict) {
                           myKanyang.Subdistrict = Subdistrict;
                        },
                      ),
                       SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ข่าวสาร',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาถนน"),
                        onSaved: (String? News) {
                           myKanyang.News = News;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'แคมเปญ',
                        ),
                        validator: RequiredValidator(errorText: "กรุณาแคมเปญ"),
                        onSaved: (String? campian) {
                           myKanyang.campian = campian;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'เบอร์ติดต่อกยท',
                        ),
                         validator: RequiredValidator(errorText: "กรุณาเบอร์โทร"),
                        onSaved: (String? telnum) {
                           myKanyang.telnum= telnum;
                        },
                        // validator: (telnum) {
                        //   if (telnum == null || telnum.isEmpty) {
                        //     return 'กรุณากรอกเบอร์ติดต่อกยท';
                        //   }
                        //   RegExp regex = RegExp(
                        //       r'^[0-9]{10}$'); // ตรวจสอบเบอร์โทรศัพท์ที่มี 10 ตัวเลข
                        //   if (!regex.hasMatch(telnum)) {
                        //     return 'เบอร์ติดต่อกยทไม่ถูกต้อง';
                        //   }
                        //   return null;
                        // },
                        // onSaved: (telnum) {
                        //   myKanyang.telnum = telnum;
                        // },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            await _kanyangCollection.add({
                              "Name": myKanyang.namekanyang,
                              "Road":myKanyang.road,
                              "Subdistrict": myKanyang.Subdistrict,
                              "TelNum": myKanyang.telnum,
                              "News": myKanyang.News,
                              "campian": myKanyang.campian,
                              // "today_date": myKanyang.today_date,
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
  String? Subdistrict;
  String? telnum;
  String? campian;
  String? News;
  late DateTime today_date;
  kanyang(
    this.namekanyang,
    this.telnum,
    this.road,
    this.Subdistrict,
    this.today_date,
    this.campian,
     this.News,
  );
}
