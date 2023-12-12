import 'package:flutter/material.dart';

class Farmer_Infor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<OrderRequestModel>(
    //   builder : (context,orderRequestmodel,child){
      return Scaffold(
        appBar: AppBar(
          title: Text('คำสั่งรับยาง'),
          titleTextStyle: 
          TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        DataTable(
        columns: <DataColumn>[
        DataColumn(
          label: Center( 
           child:Text(
            'เลขสมาชิก',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
         ), 
           DataColumn(
          label: Center( 
           child:Text(
            'ผ่านเกณฑ์',
            style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
         ), 
       ],
       rows: const<DataRow>[
       DataRow(
         cells: <DataCell>[
                DataCell(Text('10011')),
                DataCell(Text('ผ่าน')),
        ],
       ),
       DataRow(
              cells: <DataCell>[
               DataCell(Text('10012')),
                DataCell(Text('ผ่าน')),
              ],
            ),
               DataRow(
              cells: <DataCell>[
                DataCell(Text('10013')),
                DataCell(Text('ไม่ผ่าน')),
              ],
            ),
      ]
     ),
    ],
     ),
    );
   }
    // );
  }
// }