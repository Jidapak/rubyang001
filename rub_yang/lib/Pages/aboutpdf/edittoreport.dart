import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
import 'package:rub_yang/Pages/aboutpdf/reportpdf.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}
class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});

  TextEditingController NameF = TextEditingController();
  TextEditingController NameL = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Subdistrict = TextEditingController();
  TextEditingController District = TextEditingController();
TextEditingController province = TextEditingController();
  TextEditingController Teleph = TextEditingController();
  TextEditingController accountno = TextEditingController();
  TextEditingController bankname = TextEditingController();
TextEditingController accountname = TextEditingController();
  @override
  void initState() {
    NameF = TextEditingController(text: widget.docid.get('NameF'));
    NameL = TextEditingController(text: widget.docid.get('NameL'));
    Address = TextEditingController(text: widget.docid.get('Address'));
    Subdistrict = TextEditingController(text: widget.docid.get('Subdistrict'));
  District = TextEditingController(text: widget.docid.get('District'));
  province = TextEditingController(text: widget.docid.get('province'));
   Teleph = TextEditingController(text: widget.docid.get('Teleph'));
    accountno = TextEditingController(text: widget.docid.get('accountno'));
    bankname = TextEditingController(text: widget.docid.get('bankname'));
    accountname  = TextEditingController(text: widget.docid.get('accountname'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeReport()));
            },
            child: Text(
              "ย้อนกลับ",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': NameF.text,
                'Lname': NameL.text,
                'Address': Address.text,
                'Subdistrict': Subdistrict.text
              }).whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeReport()));
              });
            },
            child: Text(
              "บันทึก",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeReport()));
              });
            },
            child: Text(
              "ลบ",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: NameF,
                  decoration: InputDecoration(
                    hintText: 'Firstname',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: NameL,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Lastname',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Address,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Address',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Subdistrict,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Subdistrict',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: District,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'District',
                  ),
                ),
              ),
               SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: province,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'province',
                  ),
                ),
              ),
               SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Teleph,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Teleph',
                  ),
                ),
              ),
               SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: accountno,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'accountno',
                  ),
                ),
              ),
               SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: bankname,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'bankname',
                  ),
                ),
              ),
               SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: accountname,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'accountname',
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Colors.brown,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "สร้างรายงาน",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
