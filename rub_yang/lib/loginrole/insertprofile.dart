import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rub_yang/loginrole/Register_page2.dart';
import 'package:rub_yang/model/profile.dart';

class FarmerInsert extends StatefulWidget {
  @override
  _FarmerInsertState createState() => _FarmerInsertState();
}

class _FarmerInsertState extends State<FarmerInsert> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _accountController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  Profile myProfile = Profile("", "", "", "", "", "", "", "", "", "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profileCollection =
      FirebaseFirestore.instance.collection("farmerprofile");
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
                          'ชื่อชาวสวน',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกชื่อจริง',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกชื่อ"),
                          onSaved: (String? fname) {
                            if (fname != null) {
                              myProfile.NameF = fname;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'นามสกุลชาวสวน',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกนามสกุล',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกนามสกุล"),
                          onSaved: (String? Lname) {
                            if (Lname != null) {
                              myProfile.NameL = Lname;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ที่อยู่',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกที่อยู่',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกที่อยู่"),
                          onSaved: (String? address) {
                            if (address != null) {
                              myProfile.Address = address;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
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
                            if (subdistrict != null) {
                              myProfile.subdistrict = subdistrict;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
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
                            if (district != null) {
                              myProfile.district = district;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
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
                          onSaved: (String? Province) {
                            if (Province != null) {
                              myProfile.province = Province;
                            } else {}
                          },
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
                              myProfile.Teleph = phone.completeNumber!;
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
                        TextFormField(
                          controller: _accountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'เลขบัญชี',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกเลขบัญชี';
                            }
                            if (value.length < 12 || value.length > 15) {
                              return 'เลขบัญชีต้องมีความยาวระหว่าง 12-15 หลัก';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'เลขบัญชีต้องเป็นตัวเลขเท่านั้น';
                            }
                            return null;
                          },
                          onSaved: (String? accountno) {
                            if (accountno != null) {
                              myProfile.accountno = accountno;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ธนาคาร',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกธนาคาร',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอกธนาคาร"),
                          onSaved: (String? bankname) {
                            if (bankname != null) {
                              myProfile.bankname = bankname;
                            } else {}
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'ชื่อบัญชี',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'กรอกชื่อบัญชี',
                          ),
                          validator:
                              RequiredValidator(errorText: "กรุณากรอชื่อบัญชี"),
                          onSaved: (String? accountname) {
                            if (accountname != null) {
                              myProfile.accountname = accountname;
                            } else {}
                          },
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                formKey.currentState?.save();
                                await _profileCollection.add({
                                  "NameF": myProfile.NameF,
                                  "NameL": myProfile.NameL,
                                  "Address": myProfile.Address,
                                  "Subdistrict": myProfile.subdistrict,
                                  "District": myProfile.district,
                                  "province": myProfile.province,
                                  "Teleph": myProfile.Teleph,
                                  "accountno": myProfile.accountno,
                                  "bankname": myProfile.bankname,
                                  "accountname": myProfile.accountname,
                                });
                                formKey.currentState?.reset();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return insertSuccessDialog();
                                  },
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RubyangStore2()),
                                );
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

class Profile {
  late String NameF;
  late String NameL;
  late String Address;
  late String district;
  late String subdistrict;
  late String province;
  late String Teleph;
  late String accountno;
  late String accountname;
  late String bankname;
  Profile(
      this.NameF,
      this.NameL,
      this.Address,
      this.subdistrict,
      this.district,
      this.province,
      this.Teleph,
      this.accountno,
      this.accountname,
      this.bankname);
}

class insertSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('บันทึกข้อมูลสำเร็จ'),
      // content: Text('ขอบคุณที่ลงทะเบียน'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // ปิดป๊อบอัพ
            Navigator.pop(context); // ปิดหน้า insert ด้วย
          },
          child: Text('ตกลง'),
        ),
      ],
    );
  }
}
