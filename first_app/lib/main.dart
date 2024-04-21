import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Pages/fifth_pages.dart';
import 'package:first_app/Pages/first_pages.dart';
import 'package:first_app/Pages/fourth_pages.dart';
import 'package:first_app/Pages/home_page.dart';
import 'package:first_app/Pages/second_pages.dart';
import 'package:first_app/Pages/sixth_pages.dart';
import 'package:first_app/Pages/third_pages.dart';
import 'package:first_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context) => PreferenceModel()),
    ],
     child: const MyApp()
     ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 151, 233, 153)),
        useMaterial3: true,
      ),
      initialRoute:'/home' ,
      routes : {
      '/home':(context) => HomePage(),
      '/1': (context) => FirstPage(),
      '/2': (context) => SecondPage(),
      '/3': (context) => ThirdPage(),
      '/4': (context) => FourthPages(),
      '/5': (context) => FifthPage(),
      '/6':(context) => SixthPage(),
      },
    );
  }
}
