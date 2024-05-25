import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rub_yang/facview/listkanyang.dart';
import 'package:rub_yang/loginrole/login_pagerole.dart';

class RubyangStore2 extends StatefulWidget {
  const RubyangStore2({Key? key});
  @override
  State<RubyangStore2> createState() => _RubyangStore2State();
}

class _RubyangStore2State extends State<RubyangStore2> {
  bool showProgress = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final String role = "ร้านรับซื้อยาง";

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[700],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.brown[500],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        Text(
                          "ลงทะเบียนผู้ใช้งาน",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 50),
                        buildTextFormField(emailController, "อีเมล์", TextInputType.emailAddress, validateEmail),
                        SizedBox(height: 20),
                        buildPasswordField(passwordController, "รหัสผ่าน", _isObscure, () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                        SizedBox(height: 20),
                        buildPasswordField(confirmpassController, "ยืนยันรหัสผ่าน", _isObscure2, () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        }),
                        SizedBox(height: 20),
                        buildUserRoleDropdown(),
                        SizedBox(height: 20),
                        buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(TextEditingController controller, String hintText, TextInputType keyboardType, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabled: true,
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
      onChanged: (value) {},
      keyboardType: keyboardType,
    );
  }

  TextFormField buildPasswordField(TextEditingController controller, String hintText, bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabled: true,
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกรหัสผ่าน";
        }
        if (controller == passwordController && confirmpassController.text != value) {
          return "รหัสผ่านไม่ตรงกัน";
        }
        return null;
      },
      onChanged: (value) {},
    );
  }

  Row buildUserRoleDropdown() {
    return Row(
      children: [
        Text(
          "ประเภทผู้ใช้: ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(width: 10),
        DropdownButton<String>(
          dropdownColor: Colors.brown,
          isDense: true,
          isExpanded: false,
          iconEnabledColor: Colors.white,
          focusColor: Colors.white,
          items: ['ร้านรับซื้อยาง'].map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(
                dropDownStringItem,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (newValueSelected) {
            setState(() {
              // No state change needed as role is static
            });
          },
          value: role,
        ),
      ],
    );
  }

  Row buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListKanyang()));
          },
          child: Text("ยกเลิก"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.black),
          onPressed: () async {
            if (_formkey.currentState!.validate()) {
              setState(() {
                showProgress = true;
              });
              try {
                UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                    email: emailController.text, password: passwordController.text);
                await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                  'email': emailController.text,
                  'role': role,
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page()));
              } on FirebaseAuthException catch (e) {
                setState(() {
                  showProgress = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
              }
            }
          },
          child: Text("ลงทะเบียน"),
        ),
      ],
    );
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "กรุณากรอกอีเมล";
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return "กรุณากรอกอีเมลให้ถูกต้อง";
    }
    return null;
  }
}
