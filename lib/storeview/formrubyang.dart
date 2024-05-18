import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/paymentselected.dart';
import 'package:rub_yang/main.dart';
// import 'package:rub_yang/model/storemodel.dart';
// import 'package:rub_yang/storeview/timestep.dart';


class Formrubyang extends StatefulWidget {
  final String selectedStoreName;
  final List<dynamic> priceSheets;
  final String orderId;
  final String email;
  final String Type;
 final String  selectedPaymentMethod;
  Formrubyang({
    required this.selectedStoreName,
    required this.priceSheets,
    required this.orderId,
    required this.email,
    required this.Type,
    required this.selectedPaymentMethod,
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
        title: Text(
          'คำนวณยอดเงิน',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              SizedBox(height: 15),
              Text(
                'อีเมล์ที่ส่งคำสั่งขาย: ${widget.email}',
                style: TextStyle(
                    color: Colors.brown[800],
                    fontSize: 18,
               ),
              ),
              SizedBox(height: 20),
                Text(
                'ร้านรับซื้อ: ${widget.selectedStoreName}',
                style: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
                Text(
                'จ่ายเงินโดย: ${widget.selectedPaymentMethod}',
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
                        'ชนิดยาง: ${widget.Type}',
                        style: TextStyle(
                          color: Colors.brown[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              // SizedBox(height: 20),
              // TextFormField(
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              //   ],
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'น้ำหนักการตวง',
              //   ),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'กรุณากรอกน้ำหนักการตวง';
              //     }
              //     return null;
              //   },
              //   onSaved: (newValue) {
              //     weightofcup = double.parse(newValue!);
              //   },
              // ),
              SizedBox(height: 20),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '%DRC',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          totalPrice = widget.priceSheets[0] *
                              weightoftotal *
                              (DRCperc / 100);
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
                        builder: (context) => PaymentSelectionPage(
                          orderId: widget.orderId,
                          email: widget.email,
                          totalPrice: totalPrice,
                         selectedPaymentMethod: widget.selectedPaymentMethod,
                          weightoftotal: weightoftotal,
                          DRCpercent: DRCperc,
                          Type : widget.Type ,
                          selectedStoreName: widget.selectedStoreName,
                        ),
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

// class Formrubyang extends StatefulWidget {
//   final String selectedStoreName;
//   final List<dynamic> priceSheets;
//   final String orderId;
//   final String email;

//   Formrubyang({
//     required this.selectedStoreName,
//     required this.priceSheets,
//     required this.orderId,
//     required this.email,
//   });

//   @override
//   _FormrubyangState createState() => _FormrubyangState();
// }

// class _FormrubyangState extends State<Formrubyang> {
//   final _formKey = GlobalKey<FormState>();
//   double weightofcup = 0;
//   double DRCperc = 0;
//   double weightoftotal = 0;
//   double totalPrice = 0;
//   late Calorder myCalorder;
//   late CollectionReference _calorderCollection;
//   late Future<FirebaseApp> _firebase;

//   @override
//   void initState() {
//     super.initState();
//     _firebase = Firebase.initializeApp();
//     _calorderCollection = FirebaseFirestore.instance.collection("prices");
//     myCalorder = Calorder(
//       "",
//       "",
//       0,
//       0,
//       0,
//       0,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _firebase,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text("Error"),
//             ),
//             body: Center(
//               child: Text("${snapshot.error}"),
//             ),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'คำนวณยอดเงิน',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   letterSpacing: 2.0,
//                   color: Colors.brown,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 15),
//                     Text(
//                       'เลขคำสั่งขาย: ${widget.orderId}',
//                       style: TextStyle(
//                           color: Colors.brown[800],
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       'อีเมล์ที่ส่งคำสั่งขาย: ${widget.email}',
//                       style: TextStyle(
//                           color: Colors.brown[800],
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     SizedBox(height: 20),
//                     Container(
//                       padding: EdgeInsets.all(8.0),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         border: Border.all(
//                           color: Colors.white70,
//                           width: 6.0,
//                         ),
//                       ),
//                       child: Center(
//                         child: Column(
//                           children: [
//                             Text(
//                               'ราคา: ${widget.priceSheets[0]}',
//                               style: TextStyle(
//                                 color: Colors.brown[800],
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'น้ำหนักการตวง',
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'กรุณากรอกน้ำหนักการตวง';
//                         }
//                         return null;
//                       },
//                       onSaved: (newValue) {
//                         weightofcup = double.parse(newValue!);
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'น้ำหนัก',
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'กรุณากรอกน้ำหนักหน่วยกิโลกรัม';
//                         }
//                         return null;
//                       },
//                       onSaved: (newValue) {
//                         weightoftotal = double.parse(newValue!);
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: '%DRC',
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'กรุณากรอก%DRC';
//                         }
//                         return null;
//                       },
//                       onSaved: (newValue) {
//                         DRCperc = double.parse(newValue!);
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: Container(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _formKey.currentState!.save();
//                               setState(() {
//                                 totalPrice = widget.priceSheets[0] *
//                                     weightofcup *
//                                     weightoftotal *
//                                     DRCperc /
//                                     100;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content:
//                                       Text('ราคารวมที่ต้องจ่าย: $totalPrice'),
//                                 ),
//                               );
//                             }
//                           },
//                           child: Text('คำนวณ'),
//                           style: ButtonStyle(
//                             padding:
//                                 MaterialStateProperty.all<EdgeInsetsGeometry>(
//                               EdgeInsets.symmetric(
//                                 horizontal: 60.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     if (totalPrice > 0)
//                       GestureDetector(
//                         onTap: () async {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             _formKey.currentState?.save();
//                             // myPrice.today_date = DateTime.now();
//                             // myPrice.pricsheet_diff = myPrice.update_pricesheet -
//                             //     myPrice.daily_pricesheet;
//                             // myPrice.pricwater_diff = myPrice.update_pricewater -
//                             //     myPrice.daily_pricewater;
//                             // myPrice.pricchunk_diff = myPrice.update_pricechunk -
//                             //     myPrice.daily_pricechunk;
//                             await _calorderCollection.add({
//                               "orderId": myCalorder.orderId,
//                               "email": myCalorder.email,
//                               "totalPrice": myCalorder.totalPrice,
//                               "DRCperc": myCalorder.DRCperc,
//                               "weightofcup": myCalorder.weightofcup,
//                               "weightoftotal": myCalorder.weightoftotal,
//                             });
//                             _formKey.currentState?.reset();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PaymentSelectionPage(
//                                   orderId: widget.orderId,
//                                   email: widget.email,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         child: Card(
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'ราคารวมที่ต้องจ่าย:',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.green[600]),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     '${totalPrice.toStringAsFixed(2)} บาท',
//                                     style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.green[600]),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }

// class Calorder {
//   String? orderId;
//   String? email;
//   late num totalPrice;
//   late num DRCperc;
//   late num weightofcup;
//   late num weightoftotal;
//   Calorder(
//     this.orderId,
//     this.email,
//     this.totalPrice,
//     this.DRCperc,
//     this.weightofcup,
//     this.weightoftotal,
//   );
// }
