import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Farmer_Infor extends StatefulWidget {
  @override
  _Farmer_InforState createState() => _Farmer_InforState();
}

class _Farmer_InforState extends State<Farmer_Infor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชาวสวนที่จะเข้าร่วมขอทุนกยท',
          style: TextStyle(
            fontSize: 18.0,
            letterSpacing: 1.5,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("farmerdata").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText(
                          "ชื่อชาวสวน: ${document["namefarmer"]} ${document["lastnfarmer"]}",
                          16.0,
                        ),
                        _buildText(
                          "สัญชาติ: ${document["nationality"]}",
                          16.0,
                        ),
                        _buildText(
                          "ที่อยู่: ${document["location"]} ${document["selectedCity"]}",
                          16.0,
                        ),
                        _buildText(
                          "จังหวัด: ${document["selectedState"]} ${document["selectedCountry"]}",
                          16.0,
                        ),
                        _buildText(
                          "ขนาดฟาร์ม: ${document["areafarm"]} ไร่",
                          16.0,
                        ),
                        _buildText(
                          "จำนวนต้นยาง: ${document["quantitytree"]} ต้น",
                          16.0,
                        ),
                        _buildText(
                          "จำนวนต้นยางอายุ > 25 ปี: ${document["agetree"]}ต้น",
                          16.0,
                        ),
                        _buildText(
                          "เป็นเจ้าของสวน ?: ${document["_radioValue12"]} ",
                          16.0,
                        ),
                        _buildText(
                          "เข้าร่วมโครงการกยท ?: ${document["_radioValue11"]} ",
                          16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildText(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
