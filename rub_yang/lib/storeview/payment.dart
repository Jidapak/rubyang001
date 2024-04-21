import 'package:flutter/material.dart';

class PaymentSelection extends StatefulWidget {
  @override
  _PaymentSelectionState createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  bool _isCashSelected = true;
  bool _isBankTransferSelected = false;
  TextEditingController _bankAccountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การจ่ายเงินให้ลูกค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ช่องทางรับเงิน:',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800]),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _isCashSelected,
                  onChanged: (value) {
                    setState(() {
                      _isCashSelected = value ?? false;
                      _isBankTransferSelected = !_isCashSelected;
                    });
                  },
                ),
                Text('เงินสด'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isBankTransferSelected,
                  onChanged: (value) {
                    setState(() {
                      _isBankTransferSelected = value ?? false;
                      _isCashSelected = !_isBankTransferSelected;
                    });
                  },
                ),
                Text('โอนเงินเข้าบัญชี'),
              ],
            ),
            if (_isBankTransferSelected) ...[
              SizedBox(height: 16.0),
              Text(
                'Enter Bank Account Number:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _bankAccountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your bank account number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_isBankTransferSelected) {
                  // Perform bank transfer with account number
                  String bankAccountNumber = _bankAccountController.text;
                  // Implement your logic here
                } else {
                  // Perform cash payment
                  // Implement your logic here
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentSelection()),
                );
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 48),
                ),
              ),
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bankAccountController.dispose();
    super.dispose();
  }
}
