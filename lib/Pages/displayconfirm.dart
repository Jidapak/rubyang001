import 'package:flutter/material.dart';

class ConfirmOrderPage extends StatelessWidget {
  final String id;
  final String formattedDate;
  final String selectedTime;
  final List<num> priceSheets;
  final String selectedStoreName;
  final String rubberType;
  final String? selectedPaymentMethod;
  
  ConfirmOrderPage({
    required this.id,
    required this.formattedDate,
    required this.selectedTime,
    required this.priceSheets,
    required this.selectedStoreName,
    required this.rubberType,
    required this.selectedPaymentMethod, 
  });

  @override
  Widget build(BuildContext context) {
    // Provide a default value for selectedPaymentMethod if it is null
    final String paymentMethod = selectedPaymentMethod ?? 'ไม่ระบุ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ส่งคำสั่งขาย',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, // Make the container take the full width
              child: Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.brown, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เลขที่คำสั่งขาย:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        id,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'วันที่:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'เวลาที่เลือก:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        selectedTime,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        priceSheets.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'ร้านรับซื้อ:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        selectedStoreName,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'ชนิดยางพารา:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        rubberType,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'รับเงินโดย:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        paymentMethod, // Use the non-nullable value here
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
