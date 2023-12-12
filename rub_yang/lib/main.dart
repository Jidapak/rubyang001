import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/detail.dart';
import 'package:rub_yang/Pages/detail2.dart';
import 'package:rub_yang/Pages/farmerInfor.dart';
import 'package:rub_yang/Pages/listtab.dart';
import 'package:rub_yang/Pages/farmerform.dart';
import 'package:rub_yang/Pages/liststore.dart';
import 'package:rub_yang/storeview/pricevalue.dart';
import 'package:rub_yang/Pages/home_r.dart';
import 'package:rub_yang/Pages/landing.dart';
import 'package:rub_yang/Pages/list_trade.dart';
import 'package:rub_yang/Pages/confirmorder.dart';
import 'package:rub_yang/Pages/groupchat.dart';
import 'package:rub_yang/Pages/type_spotf.dart';
import 'package:rub_yang/Pages/knowledge.dart';
import 'package:rub_yang/facview/homefac.dart'; 
import 'package:rub_yang/storeview/homestore.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderRequestModel(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surat_Rubyang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown, 
        ),
        useMaterial3: true,
      ),
      initialRoute: '/9',
      routes: {
        '/home': (context) => HomePageR(),
        '/1': (context) => ListStore(),
        '/2': (context) => ConfirmO(),
        '/3': (context) => Knowledge(),
        '/6': (context) => PriceValue(),
        '/4': (context) => FarmerForm(),
        '/5': (context) => GroupChat(),
        'spot_f': (context) => Spot_F(),
        'list_trade':(context) => List_trade(),
        '/7':(context) => HomeStore(),
        '/8':(context) => HomeFactory(),
        '/9':(context) => LandingPage(),
        '/10':(context)=> ListTab(),
        '/11': (context) => Farmer_Infor(),
      },
    );
  }
}
