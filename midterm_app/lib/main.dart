import 'package:flutter/material.dart';
import 'package:midterm_app/Pages/list_form.dart';
import 'package:midterm_app/Pages/news_mid.dart';
import 'package:midterm_app/Pages/open_price.dart';
import 'package:midterm_app/Pages/group_mid.dart';
import 'package:midterm_app/Pages/home_mid.dart';
import 'package:midterm_app/Pages/location_m.dart';
import 'package:midterm_app/Pages/product_type.dart';
import 'package:midterm_app/Pages/history_adopt.dart';
import 'package:midterm_app/Pages/typetrade.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>  OrderRequestModel(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetsCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal, 
        ),
        useMaterial3: true,
      ),
      initialRoute: '/home_midterm',
      routes: {
        '/home_midterm': (context) => HomePageMid(),
        '/1': (context) => product_type(),
        '/2': (context) => history(),
        '/3': (context) => news_mid(),
        '/4': (context) => open_price(),
        '/5': (context) => location_m(),
        '/6': (context) => group_mid(),
        'list_form': (context) => List_form(),
        'type_trade':(context) => type_trade(),
      },
    );
  }
}
