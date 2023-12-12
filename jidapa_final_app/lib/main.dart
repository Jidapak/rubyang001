import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jidapa_final_app/bookingpage.dart';
import 'package:jidapa_final_app/confirm.dart';
import 'package:jidapa_final_app/listpage.dart';
import 'package:jidapa_final_app/firebase_options.dart';
import 'package:jidapa_final_app/homepage.dart';
import 'package:jidapa_final_app/model/model.dart';
import 'package:provider/provider.dart';

void main()  async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MovieProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RequestModel(),
      ),
      ],
    child: const MyApp(),
  ));
}
class MyApp extends StatefulWidget {
   const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white54,
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/1':(context)=>ListPage() ,
        '2':(context) => BookingApp(),
        '/4':(context) => BookingListPage(),
      },
    );
  }
}