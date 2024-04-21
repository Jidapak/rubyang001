import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/login.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 140),
            width: double.infinity,
            height: 460,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 235),
                  Text(
                    'เพื่อนชาวสวนยางสุราษฎร์ธานี',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(height:20),
                  Expanded(
                    child: Text(
                      'รับยางว่องไว ใส่ใจคุณภาพ \n ดูแลพัฒนา ยกระดับคุณภาพ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white60,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white70),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'เริ่มใช้งาน',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Image.asset(
              'images/rubber1.png',
              height: 400,
            ),
          ),
          Stack(
            children: [
              _ListContainer(),
            ],
          ),
          Positioned(
            top: 46,
            right: 65,
            child: Text(
              auth.currentUser?.email ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 12,
            child: IconButton(
              onPressed: () {
                auth.signOut().then((value){
                 Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context) {
                 return LoginPage();
                }));
              },);
              },
              icon: Icon(Icons.logout_outlined), 
              color: Colors.black87,
              iconSize: 26, 
            ),
          ),
        ],
      ),
    );
  }

  Widget _ListContainer() {
    return Positioned(
      top: 630,
      left: 2.5,
      right: 2.5,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white60.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 100,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'images/store1.png',
                width: 100,
                height: 100,
              ),
            ),
            Container(
              width: 290,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      ' ร้านรับยางสุราษฎร์',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/10');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white70),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(16.0),
                      ),
                    ),
                    child: Text(
                      'เริ่มใช้งาน',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
