import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/loginrole/login_pagerole.dart';

class Farmer extends StatefulWidget {
  const Farmer({super.key});
  @override
  State<Farmer> createState() => _FarmerState();
}
class _FarmerState extends State<Farmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
        Positioned(
            top: 46,
            right: 65,
            child: Text(
                'ผู้ใช้งาน : ${FirebaseAuth.instance.currentUser?.email ?? ''}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[500],
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout_outlined,
            size: 25,
            color:  Colors.brown[500],
            ),
          )
        ],
      ),
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
                  SizedBox(height:220),
                  Text(
                    'เพื่อนชาวสวนยางสุราษฎร์ธานี',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(height: 10),
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
        ],
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Login_Page(),
    ),
  );
}
