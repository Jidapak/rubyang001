import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget{
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User : ${user.email} is signed in!');
    }
  });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('First Page'),
        actions: [
          IconButton(onPressed:(){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hello ...'),
                ),
            );
          }, 
          icon: Icon(Icons.add_alert), 
          ),
          IconButton(onPressed:(){
            Navigator.pushNamed(context, '/second');
          }, 
          icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
      body: Center(
        child: Column(
        children: [  
        ElevatedButton(
          onPressed: () async {
            try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'jidapa-kam65@tbs.tu.ac.th',
    password: '016766104',
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
          }, 
          child: Text('Login'),
        ),
        ElevatedButton(
          onPressed: () {          
            FirebaseAuth.instance.signOut();
          },
          child: Text('Logout'),
        ),
      ]
      ),
    ),
    );
  } 
}