import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmOrderPage extends StatelessWidget {
  final String id;
  final String formattedDate;
  final String selectedTime;
  final List<num> priceSheets;
  final String selectedStoreName;
  final String rubberType;

  ConfirmOrderPage({
    required this.id,
    required this.formattedDate,
    required this.selectedTime,
    required this.priceSheets,
    required this.selectedStoreName,
    required this.rubberType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
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
                        SizedBox(height: 20),
                        Text(
                          'เลขที่คำสั่งขาย: $id',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'วันที่ไปส่ง: $formattedDate',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'เวลาที่ไปส่ง: $selectedTime',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'ราคาขาย: ${priceSheets.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'ร้านรับซื้อ: $selectedStoreName',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'ชนิดยาง: $rubberType',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
