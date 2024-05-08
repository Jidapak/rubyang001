import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FormFactory extends StatefulWidget {
  const FormFactory({Key? key}) : super(key: key);

  @override
  _FormFactoryState createState() => _FormFactoryState();
}

class _FormFactoryState extends State<FormFactory> {
  final formKey = GlobalKey<FormState>();
  String namerubyang = '';
  String namefactory = '';
  String quanlityyang = '';
  num totalpay = 0;
  num totalkg = 0;
  num totalquantity = 0;
  String _radioValue12 = '';
  late CollectionReference _factoryDataCollection;
  late Future<FirebaseApp> _firebase;

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _factoryDataCollection =
        FirebaseFirestore.instance.collection("factorydata");
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
              title: Text(
                'ฟอร์มส่งโรงงาน',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                height: 1000,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: CustomScrollView(slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'ชื่อร้านรับซื้อ',
                                  prefixIcon: Icon(Icons.store),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกชื่อร้านรับซื้อ';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    namerubyang = newValue!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'ชื่อโรงงาน',
                                  hintText: 'กรอกชื่อชื่อโรงงานที่ไปส่ง',
                                  prefixIcon: Icon(Icons.factory),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกชื่อโรงงาน';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    namefactory = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'คุณภาพยาง',
                                  prefixIcon: Icon(Icons.percent),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกคุณภาพยาง';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    quanlityyang = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'ยอดเงินรวม',
                                  prefixIcon: Icon(Icons.money),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกยอดเงินรวม';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    totalpay = double.parse(newValue!);
                                  });
                                },
                              ),
                            ),
                            // const SizedBox(width: 10.0),
                            // Expanded(
                            //   child: TextFormField(
                            //     decoration: InputDecoration(
                            //       labelText: 'จำนวนรวมกิโลกรัม',
                            //       prefixIcon: Icon(Icons.monitor_weight),
                            //     ),
                            //     validator: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return 'กรุณาจำนวนรวม';
                            //       }
                            //       return null;
                            //     },
                            //     onSaved: (newValue) {
                            //       setState(() {
                            //         totalkg = double.parse(newValue!);
                            //       });
                            //     },
                            //   ),
                            // ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'จำนวนกิโลกรัมรวม',
                                              prefixIcon: Icon(Icons.monitor_weight),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'กรุณาจำนวนกกรวม';
                                              }
                                              return null;
                                            },
                                            onSaved: (newValue) {
                                              setState(() {
                                                totalquantity = double.parse(newValue!);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              'รูปแบบยางพาราที่นำไปขาย',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '1.รูปแบบยางน้ำ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Radio(
                                  value: 'รูปแบบยางน้ำ',
                                  groupValue: _radioValue12,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue12 = value.toString();
                                    });
                                  },
                                ),
                                Text(
                                  '2.รูปแบบยางแผ่น',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Radio(
                                  value: 'รูปแบบยางแผ่น',
                                  groupValue: _radioValue12,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue12 = value.toString();
                                    });
                                  },
                                ),
                                Text(
                                  '3.รูปแบบยางก้อน',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Radio(
                                  value: 'รูปแบบยางก้อน',
                                  groupValue: _radioValue12,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue12 = value.toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        Colors.brown), 
                                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60)),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    formKey.currentState?.save();
                                    await _factoryDataCollection.add({
                                      'namerubyang': namerubyang,
                                      'namefactory': namefactory,
                                      'quanlityyang': quanlityyang,
                                      'totalpay': totalpay,
                                      'totalquantity': totalquantity,
                                      '_radioValue12': _radioValue12,
                                       'timestamp': DateTime.now(),
                                    });
                                    formKey.currentState?.reset();
                                  }
                                },
                                child: Text(
                                  'บันทึก',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        }
        // Return a loading indicator while the connection state is not done
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class FactoryData {
  // String id = "";
  String namerubyang = '';
  String namefactory = '';
  String quanlityyang = '';
  num totalpay = 0;
  num totalkg = 0;
  num totalquantity = 0;
   String _radioValue12 = '';

  FactoryData(
    // this.id,
    this.namerubyang,
    this.namefactory,
    this.quanlityyang,
    this.totalpay,
    this.totalkg,
    this.totalquantity,
    this._radioValue12,
  );
}
