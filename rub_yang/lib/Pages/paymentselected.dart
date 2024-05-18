import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/storeview/cashpayment.dart';
import 'package:rub_yang/storeview/tranformerpayment.dart';

class PaymentSelectionPage extends StatefulWidget {
  final String orderId;
  final String email;
  final double totalPrice;
  // final double weightofcup;
  final double weightoftotal;
  final double DRCpercent;
  final String Type;
  final String selectedStoreName;
final String selectedPaymentMethod;
  PaymentSelectionPage({
    required this.orderId,
    required this.email,
    required this.totalPrice,
    // required this.weightofcup,
    required this.weightoftotal,
    required this.DRCpercent,
    required this.Type,
    required this.selectedStoreName,
    required this.selectedPaymentMethod
  });

  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String? _selectedPaymentMethod;
  late CollectionReference _PaymentSelectionCollection;
  late Future<FirebaseApp> _firebase = Firebase.initializeApp();
  late Calorder myCalorder;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firebase = Firebase.initializeApp();
    _PaymentSelectionCollection =
        FirebaseFirestore.instance.collection("calculateorders");
    myCalorder = Calorder(
      widget.orderId,
      widget.email,
      widget.totalPrice,
      widget.DRCpercent,
      // widget.weightofcup,
      widget.weightoftotal,
      '', // Initializes selectedPaymentMethod as empty string
      widget.selectedStoreName,
    );
    super.initState();
  }

  void _saveOrderToFirestore() async {
    try {
      await _PaymentSelectionCollection.add({
        'orderId': widget.orderId,
        'email': widget.email,
        'totalPrice': widget.totalPrice,
        'DRCpercent': widget.DRCpercent,
        // 'weightofcup': widget.weightofcup,
        'weightoftotal': widget.weightoftotal,
        'Type': widget.Type,
        'selectedPaymentMethod': _selectedPaymentMethod,
        'selectedStoreName': widget.selectedStoreName,
        'timestamp': DateTime.now(),
      });

      if (_selectedPaymentMethod == 'โอนเงิน') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransferPaymentPage(
              selectedStoreName: widget.selectedStoreName,
              email: widget.email,
              orderId: widget.orderId,
              totalPrice: widget.totalPrice,
              Type: widget.Type,
            ),
          ),
        );
      } else if (_selectedPaymentMethod == 'เงินสด') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CashPaymentPage(
              email: widget.email,
              orderId: widget.orderId,
              totalPrice: widget.totalPrice,
              Type: widget.Type,
              selectedStoreName: widget.selectedStoreName,
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save order to Firestore: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
                'เลือกวิธีการชำระเงิน',
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
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'เลขที่คำสั่งขาย: ${widget.orderId}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[800],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'อีเมล์: ${widget.email}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'ร้านรับซื้อ: ${widget.selectedStoreName}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(
                        'ยอดเงินที่ต้องจ่าย: ${widget.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromRGBO(78, 52, 46, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'เปอร์เซนต์DRC: ${widget.DRCpercent}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.brown[800],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // SizedBox(height: 10),
                        // Text(
                        //   'น้ำหนักตวง: ${widget.weightofcup}',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.brown[800],
                        //     fontWeight: FontWeight.w300,
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        Text(
                          'น้ำหนักรวม: ${widget.weightoftotal} กิโลกรัม',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.brown[800],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'โปรดเลือกวิธีการชำระเงิน:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800]),
                  ),
                  SizedBox(height: 20),
                  RadioListTile(
                    title: Text('ชำระเงินด้วยโอนเงิน'),
                    value: 'โอนเงิน',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('ชำระเงินด้วยเงินสด'),
                    value: 'เงินสด',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value as String?;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedPaymentMethod == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('ข้อผิดพลาด'),
                                content: Text('โปรดเลือกวิธีการชำระเงิน'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ตกลง'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          _saveOrderToFirestore();
                        }
                      },
                      child: Text(
                        'ดำเนินการต่อ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class Calorder {
  String? orderId;
  String? email;
  late num totalPrice;
  late num DRCperc;
  late num weightoftotal;
  String __selectedPaymentMethod;
  String selectedStoreName;
  Calorder(this.orderId, this.email, this.totalPrice, this.DRCperc,
    this.weightoftotal, this.__selectedPaymentMethod, this.selectedStoreName);
}
