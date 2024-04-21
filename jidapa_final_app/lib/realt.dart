import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InsertPrice extends StatefulWidget{
   const InsertPrice({Key? key}) : super(key: key);
  @override
  State<InsertPrice> createState() => _InsertPriceState();
}
class _InsertPriceState extends State<InsertPrice> {
final  userNameController = TextEditingController();
final  userPriceController= TextEditingController(); 
late DatabaseReference dbRef;
@override
void initState(){
  super.initState();
dbRef=FirebaseDatabase.instance.ref().child('user');
}
 DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: jidapa_fi.app(),
          databaseURL:
              'https://is767-2023-final-exam-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref();
@override
Widget build(BuildContext context){
return Scaffold(
  appBar: AppBar(
        title: Text('Inserting data'),
      ),
  body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Inserting data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                  hintText: 'Enter Your Price',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> stores = {
                    'name': userNameController.text,
                    'age': userPriceController.text,
                  };
                  dbRef.push().set(stores);
                },
                child: const Text('Insert Data'),
                color: Colors.brown,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}