import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rub_yang/Pages/login.dart';
import 'package:rub_yang/model/profile.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              appBar: AppBar(
                title: Text('สร้างบัญชีผู้ใช้งาน'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("อีเมล์"),
                        TextFormField(
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
                        Text("รหัสผ่าน"),
                        TextFormField(
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
                            'ลงทะเบียน',
                            style: TextStyle(fontSize: 18),
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
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password)
                                   .then((value) {
                                  formKey.currentState!.reset();
                                Fluttertoast.showToast(
                                    msg: "สร้างบัญชีผู้ใช้งานเรียบร้อยแล้ว",
                                    gravity: ToastGravity.TOP
                                    );
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              });
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                String message;
                                if (e.code == 'email-already-in-use') {
                                  message = "มีอีเมล์นี้ในระบบแล้ว";
                                } else if (e.code == 'weak-password') {
                                  message = "รหัสผ่านต้องมี6ตัวอักษรขึ้นไป";
                                } else {
                                  message = e.message!;
                                }
                                Fluttertoast.showToast(
                                    msg: e.message!,
                                    gravity: ToastGravity.CENTER);
                              }
                              // print(
                              //     "email = ${profile.email} password = ${profile.password}");
                            }
                          },
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

            // TextField(
            //   controller: emailController,
            //   decoration: InputDecoration(
            //     labelText: 'Email',
            //   ),
            // ),
        
            // TextField(
            //   controller: passwordController,
            //   decoration: InputDecoration(
            //     labelText: 'Password',
            //     suffixIcon: IconButton(
            //       icon: Icon(
            //         _obscurePassword ? Icons.visibility : Icons.visibility_off,
            //       ),
            //       onPressed: () {
            //         // setState(() {
            //         //   _obscurePassword = !_obscurePassword;
            //         // });
            //       },
            //     ),
            //   ),
            // ),
    


  //           obscureText: _obscurePassword,
  //         ),
  //         SizedBox(height: 16),
  //         ElevatedButton(
  //           onPressed: () {
  //             register(context);
  //           },
  //           child: Text('Register'),
  //         ),
  //       ],
  //     ),
  //   ),
  // );

//   void register(BuildContext context) async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email and password')));
//       return;
//     }

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       print('User registered: ${userCredential.user}');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
//       // เพิ่มโค้ดสำหรับนำผู้ใช้ไปยังหน้าหลักหรือหน้าอื่นๆ ตามที่ต้องการ
//     } catch (e) {
//       print('Error registering: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }
// }




// GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // bool _obscurePassword = true;
 
//   final Future<FirebaseApp> firebase =Firebase.initializeApp();
//   @override
//  Widget build(BuildContext context) {
//   return FutureBuilder(
//     future: firebase,
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         throw Exception("Failed to load data: ${snapshot.error}");
//       }
//       return Scaffold();
//     },
//   );
// }
