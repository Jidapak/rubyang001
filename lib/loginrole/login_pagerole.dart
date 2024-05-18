import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/Pages/landing.dart';
import 'package:rub_yang/loginrole/admin.dart';
import 'package:rub_yang/loginrole/farmer.dart';
import 'package:rub_yang/loginrole/register_page.dart';
import 'package:rub_yang/loginrole/rubyangstore.dart';

class Login_Page extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<Login_Page> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    'images/yangpara.png',
                    width: 280,
                    height: 260,
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.only(
                            left: 14.0,
                            bottom: 8.0,
                            top: 8.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure3
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.only(
                            left: 14.0,
                            bottom: 8.0,
                            top: 15.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              visible = true;
                            });
                            await signIn(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            "เข้าสู่ระบบ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minWidth: double.infinity,
                      ),
                      Visibility(
                        visible: visible,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register_page(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      "ลงทะเบียน",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  color: Colors.brown[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minWidth: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    print("signindiscall");
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("signinsuccess");
      await route(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      print("erroroccured at signin");
      if (e.code == 'ไม่พบบัญชีผู้ใช้') {
        print('ไม่พบอีเมล์ดังกล่าว.');
      } else if (e.code == 'รหัสผ่านไม่ถูกต้อง') {
        print('Wrong password provided for that user.');
      }
      setState(() {
        visible = false;
      });
    }catch(e){print("unknow error");} 
  }
Future<void> route(User user) async {
  print("user$user");
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

  if (documentSnapshot.exists) {
    String role = documentSnapshot.get('role'); 
    if (role == "ชาวสวน") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Farmer(),
        ),
      );
    } else if (role == "ร้านรับซื้อยาง") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
           builder: (context) => RubyangStore(),
        ),
      );
    } else if (role == "ผู้ดูแลระบบ") { 
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (context) => Admin(),
            builder: (context) => LandingPage(),
        ),
      );
    }
  }
}
}