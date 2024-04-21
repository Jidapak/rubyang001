import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class displayprice extends StatefulWidget{
  @override
  _displaypriceState createState() => _displaypriceState();
}
class _displaypriceState extends State<displayprice>{
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ราคาแต่ละร้าน"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("prices").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
               DateTime todayDate = (document["today_date"] as Timestamp).toDate();
               String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(todayDate);
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                child: ListTile(
                  tileColor: Colors.brown[800],
                  leading: Container(
                    width: 80, 
                    height: 150, 
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 152, 131, 122), 
                      borderRadius: BorderRadius.circular(16), 
                    ),
                    child: FittedBox(
                      child: Text(
                        document["id_store"],
                        style: TextStyle(
                            color:  Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ราคาปัจจุบัน: ${document["daily_price"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "ราคาที่อัพเดท: ${document["update_price"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "ผลต่างราคา: ${document["price_difference"]}",
                        style: TextStyle(color: Colors.white),
                      ),
                    Text(
                        "วันที่: $formattedDate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Time_Slot()),
      //     );
      //   },
      // ),
    );
  }
}

