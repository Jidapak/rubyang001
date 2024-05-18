import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport2.dart';
import 'package:rub_yang/Pages/aboutpdf/pdfpayment.dart';
import 'package:rub_yang/Pages/aboutpdf/reportpdf.dart';
import 'package:rub_yang/Pages/aboutpdf/reportpdfpayment.dart';

class editnote3 extends StatefulWidget {
  DocumentSnapshot docid;
  editnote3({required this.docid});

  @override
  _editnote3State createState() => _editnote3State(docid: docid);
}

class _editnote3State extends State<editnote3> {
  DocumentSnapshot docid;
  _editnote3State({required this.docid});

  TextEditingController  orderId = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController selectedPaymentMethod = TextEditingController();
  TextEditingController  DRCpercent = TextEditingController();
  TextEditingController weightofcup= TextEditingController();
  TextEditingController weightoftotal= TextEditingController();
  TextEditingController   totalPrice= TextEditingController();
  TextEditingController timestamp = TextEditingController();
  // TextEditingController quantitytree = TextEditingController();
  // TextEditingController selectedCity = TextEditingController();
  // TextEditingController location = TextEditingController();
  // TextEditingController selectedCountry = TextEditingController();
  // TextEditingController selectedState = TextEditingController();
  @override
void initState() {
  super.initState();
  setState(() {
    orderId.text = widget.docid.get('orderId') ?? '';
    email.text = widget.docid.get('email') ?? '';
    selectedPaymentMethod.text = widget.docid.get('selectedPaymentMethod ') ?? '';
    DRCpercent.text = widget.docid.get('DRCpercent').tonum() ?? '';
    weightofcup.text = widget.docid.get('weightofcup').tonum() ?? '';
    weightoftotal.text = widget.docid.get('weightoftotal').tonum() ?? '';
    totalPrice.text = widget.docid.get('totalPrice').toString() ?? '';
    timestamp.text = widget.docid.get('timestamp').toString() ?? '';
  });
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
                'orderId': orderId.text,
                'email': email.text,
                // 'telnum': telnum.text,
                'selectedPaymentMethod': selectedPaymentMethod.text,
                'DRCpercent': DRCpercent.text,
                'weightofcup':weightofcup.text,
                'weightoftotal':weightoftotal.text,
                'totalPrice':totalPrice,
                'timestamp':timestamp,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) =>PDFpayment()));
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
                  controller: orderId,
                  decoration: InputDecoration(
                    hintText: 'orderId',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: email,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: selectedPaymentMethod,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'selectedPaymentMethod',
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
                  controller: DRCpercent,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'DRCpercent',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: weightofcup,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'weightofcup',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller:  weightoftotal,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: ' weightoftotal',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: totalPrice,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'totalPrice',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: timestamp,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'timestamp',
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
                      builder: (_) => reportt3(
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
