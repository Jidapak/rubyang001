import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rub_yang/Pages/landing.dart';
import 'package:rub_yang/model/profile.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   String user='';
   String password='';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0, bottom: 40.0),
                          child: Image.asset(
                            'images/yangpara.png',
                            width: 250,
                            height: 260,
                          ),
                        ),
                        Text(
                          "อีเมล์",
                        style :TextStyle(
                        color: const Color.fromARGB(255, 94, 45, 27),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        TextFormField(
                          onChanged:(value) => user =value.trim(),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "กรุณาป้อนอีเมล์ด้วยค่ะ"),
                            EmailValidator(
                                errorText: "รูปแบบอีเมล์ไม่ถูกต้องค่ะ")
                          ]),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) {
                            if (email != null) {
                              profile.email = email;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'กรอกอีเมล์',
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("รหัสผ่าน",
                         style :TextStyle(
                        color: const Color.fromARGB(255, 94, 45, 27),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        TextFormField(
                          onChanged: (value) => password =value.trim(),
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนรหัสผ่านด้วยค่ะ"),
                          controller: _passwordController,
                          obscureText: true,
                          onSaved: (String? password) {
                            if (password != null) {
                              profile.password = password;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'กรอกรหัสผ่าน ',
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          child: Text(
                            'ลงชื่อเข้าใช้',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: profile.email, 
                                  password: profile.password).then((value){
                                  formKey.currentState!.reset();
                                    Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LandingPage();
                                }));
                                  }
                              );
                              } on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                    msg: e.message!,
                                    gravity: ToastGravity.CENTER);
                              }
                            }
                          },
                        ),
                     SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                               Navigator.pushNamed(context, '/forgotpw');
                            },
                            child: Text(
                              'ลืมรหัสผ่าน',
                              style: TextStyle(
                                fontSize: 15, 
                                color: Colors.white
                                ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'สมัครสมาชิก',
                              style: TextStyle(
                                fontSize: 18, 
                              color: const Color.fromARGB(255, 116, 68, 51),
                              fontWeight: FontWeight.bold
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
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
// void processLogin(BuildContext context) async {
//   String email = emailController.text.trim();
//   String password = passwordController.text.trim();
//   if (email.isEmpty || password.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('กรุณากรอกอีเมลและรหัสผ่าน')));
//     return;
//   }
//   try {
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     print('ผู้ใช้เข้าสู่ระบบ: ${userCredential.user}');
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('เข้าสู่ระบบสำเร็จ')));
//   } catch (e) {
//     print('Error: $e');
//     String errorMessage = 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ';
//     if (e is FirebaseAuthException) {
//       if (e.code == 'ไม่พบอีเมล์' || e.code == 'รหัสผ่านผิด') {
//         errorMessage = 'อีเมล์หรือรหัสผ่านไม่ถูกต้อง';
//       }
//     }
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(errorMessage)));
//   }
// }
// }