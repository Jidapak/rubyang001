import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport2.dart';
import 'package:rub_yang/Pages/aboutpdf/reportpdf.dart';

class editnote2 extends StatefulWidget {
  DocumentSnapshot docid;
  editnote2({required this.docid});

  @override
  _editnote2State createState() => _editnote2State(docid: docid);
}

class _editnote2State extends State<editnote2> {
  DocumentSnapshot docid;
  _editnote2State({required this.docid});

  TextEditingController namefarmer = TextEditingController();
  TextEditingController lastnfarmer = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController telnum = TextEditingController();
  TextEditingController _radioValue12 = TextEditingController();
  TextEditingController _radioValue11 = TextEditingController();
  TextEditingController areafarm = TextEditingController();
  TextEditingController agetree = TextEditingController();
  TextEditingController quantitytree = TextEditingController();
  TextEditingController selectedCity = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController selectedCountry = TextEditingController();
  TextEditingController selectedState = TextEditingController();
  @override
  void initState() {
    namefarmer = TextEditingController(text: widget.docid.get('namefarmer'));
    lastnfarmer = TextEditingController(text: widget.docid.get('lastnfarmer'));
    nationality = TextEditingController(text: widget.docid.get('nationality'));
    telnum = TextEditingController(text: widget.docid.get('telnum'));
    _radioValue12  = TextEditingController(text: widget.docid.get('_radioValue12'));
   _radioValue11  = TextEditingController(text: widget.docid.get('_radioValue11'));
    areafarm  = TextEditingController(text: widget.docid.get('areafarm'));
    agetree = TextEditingController(text: widget.docid.get('agetree'));
    quantitytree = TextEditingController(text: widget.docid.get('quantitytree'));
    selectedCity = TextEditingController(text: widget.docid.get('selectedCity'));
     selectedCountry = TextEditingController(text: widget.docid.get('selectedCountry'));
    selectedState = TextEditingController(text: widget.docid.get('selectedState'));
    location = TextEditingController(text: widget.docid.get('location'));
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomeReport2()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'namefarmer': namefarmer.text,
                'lastnfarmer': lastnfarmer.text,
                // 'telnum': telnum.text,
                '_radioValue12': _radioValue12.text,
                '_radioValue11': _radioValue11.text,
                'areafarm':areafarm.text,
                'agetree':agetree.text,
                'quantitytree':quantitytree,
                'location':location,
                'selectedCity':selectedCity,
                'selectedCountry':selectedCountry,
                'selectedState':selectedState,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeReport()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeReport()));
              });
            },
            child: Text(
              "delete",
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
                  controller: namefarmer,
                  decoration: InputDecoration(
                    hintText: 'Firstname',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: lastnfarmer,
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
                  controller: nationality,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'nationality',
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Container(
              //   decoration: BoxDecoration(border: Border.all()),
              //   child: TextField(
              //     controller: telnum,
              //     maxLines: null,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       hintText: 'telnum',
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: _radioValue12,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '_radioValue12',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: _radioValue11,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '_radioValue11',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: areafarm,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'areafarm',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: agetree,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'agetree',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: quantitytree,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'quantitytree',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: location ,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'location',
                  ),
                ),
              ),
                  SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: selectedCity ,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'selectedCity',
                  ),
                ),
              ),
                  SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: selectedState,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'selectedState',
                  ),
                ),
              ),
                  SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: selectedCountry,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'selectedCountry',
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
                  "สร้างรายงานPDF",
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
