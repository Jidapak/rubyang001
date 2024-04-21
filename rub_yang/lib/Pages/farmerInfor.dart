import 'package:flutter/material.dart';

class Farmer_Infor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชาวสวนที่มีต้นไม้อายุเกิน 25 ปี',
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.5,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.brown,
              ),
              dataRowHeight: 60,
              columnSpacing: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.brown, 
                  width: 1.0,
                ),
              ),
              columns: <DataColumn>[
                DataColumn(
                  label: Center(
                    child: Text(
                      'เลขสมาชิก',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'ผ่านเกณฑ์',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Center(
                        child: Text(
                          '10011',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'สนใจเข้าร่วม',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Center(
                        child: Text(
                          '10012',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ไม่ส่วนใจ\nเข้าร่วม',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Center(
                        child: Text(
                          '10013',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ไม่ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ข้อ 1 และ\n2 ไม่ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Center(
                        child: Text(
                          '10014',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ไม่ส่วนใจ\nเข้าร่วม',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Center(
                        child: Text(
                          '10015',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ไม่ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'ข้อ 1 และ\n2 ไม่ผ่าน',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
