// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/paymentselected.dart';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/storeview/timestep.dart';

class Formrubyang extends StatefulWidget {
  final String selectedStoreName;
  final List<dynamic> priceSheets;
  final String orderId;
  // final Function(String) navigateToPaymentPage; // Callback function

  Formrubyang({
    required this.selectedStoreName,
    required this.priceSheets,
    required this.orderId,
    // required this.navigateToPaymentPage, // Accept the callback function
  });

  @override
  _FormrubyangState createState() => _FormrubyangState();
}

class _FormrubyangState extends State<Formrubyang> {
  final _formKey = GlobalKey<FormState>();
  double weightofcup = 0;
  double DRCperc = 0;
  double weightoftotal = 0;
  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คำนวณยอดเงิน'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'คำนวณยอดเงินที่มาส่งขาย',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'เลขคำสั่งขาย: ${widget.orderId}',
                style: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.white70,
                    width: 6.0,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'ราคา: ${widget.priceSheets[0]}',
                        style: TextStyle(
                          color: Colors.brown[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'น้ำหนักการตวง',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกน้ำหนักการตวง';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  weightofcup = double.parse(newValue!);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'น้ำหนัก',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกน้ำหนักหน่วยกิโลกรัม';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  weightoftotal = double.parse(newValue!);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '%DRC',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก%DRC';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  DRCperc = double.parse(newValue!);
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200, // Set the desired width here
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          totalPrice = widget.priceSheets[0] *
                              weightofcup *
                              weightoftotal *
                              DRCperc /
                              100;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('ราคารวมที่ต้องจ่าย: $totalPrice'),
                          ),
                        );
                      }
                    },
                    child: Text('คำนวณ'),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                          horizontal: 60.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              if (totalPrice > 0)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
              builder: (context) => PaymentSelectionPage(orderId: widget.orderId),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ราคารวมที่ต้องจ่าย:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[600]),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${totalPrice.toStringAsFixed(2)} บาท',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[600]),
                            ),
                          ],
                        ),
                      ),
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
