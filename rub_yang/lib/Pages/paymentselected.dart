import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentSelectionPage extends StatefulWidget {
  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกวิธีการชำระเงิน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'โปรดเลือกวิธีการชำระเงิน:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod == null) {
                  // แสดงข้อความแจ้งเตือนถ้าผู้ใช้ไม่ได้เลือกวิธีการชำระเงิน
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
                  // ทำตามการดำเนินการต่อไปตามวิธีการที่ผู้ใช้เลือก
                  if (_selectedPaymentMethod == 'โอนเงิน') {
                    // ไปยังหน้าชำระเงินด้วยโอนเงิน
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferPaymentPage(),
                      ),
                    );
                  } else if (_selectedPaymentMethod == 'เงินสด') {
                    // ไปยังหน้าชำระเงินด้วยเงินสด
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashPaymentPage(),
                      ),
                    );
                  }
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
          ],
        ),
      ),
    );
  }
}

class CashPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ชำระเงินด้วยเงินสด'),
      ),
      body: Center(
        child: Text(
          'หน้านี้เป็นหน้าชำระเงินด้วยเงินสด',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class TransferPaymentPage extends StatefulWidget {
  @override
  _TransferPaymentPageState createState() => _TransferPaymentPageState();
}

class _TransferPaymentPageState extends State<TransferPaymentPage> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกวิธีการชำระเงิน'),
      ),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("farmerprofile").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var farmerprofile = snapshot.data!.docs.first;
          var accountno = farmerprofile['accountno'];
          var bankname = farmerprofile['bankname'];
          var accountname = farmerprofile['accountname'];
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'โอนเงินไปยังบัญชีธนาคาร',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ธนาคาร: $bankname',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'เลขบัญชี: $accountno',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'ชื่อบัญชี: $accountname',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
