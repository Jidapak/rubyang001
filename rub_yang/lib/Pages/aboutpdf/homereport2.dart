import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:rub_yang/Pages/aboutpdf/addreport1.dart';
import 'package:rub_yang/Pages/aboutpdf/edittoreport.dart';
import 'package:rub_yang/Pages/aboutpdf/edittoreport2.dart';
import 'package:rub_yang/Pages/aboutpdf/reportpdf2.dart';
import 'package:rub_yang/storeview/insertvalue.dart';

class HomeReport2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<HomeReport2> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('farmerdata').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.brown,
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => addreportfarmer()));
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
        title: Text(
          'รายการรายงาน',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.brown,
          ),
          onPressed: () {
            Navigator.pop(context);

          },
        ),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("ไม่มีข้อมูล"),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            reportt2(docid: snapshot.data!.docs[index]),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            "รายงานประวัติชาวสวน: ${snapshot.data!.docs[index]['lastnfarmer']} ${snapshot.data!.docs[index]['lastnfarmer']}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
