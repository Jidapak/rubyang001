import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
// import 'package:rub_yang/Pages/bookingsceen.dart';
// import 'package:rub_yang/Pages/detail.dart';
// import 'package:rub_yang/Pages/detail2.dart';
import 'package:rub_yang/Pages/displayprice.dart';
import 'package:rub_yang/Pages/farmerInfor.dart';
import 'package:rub_yang/Pages/farmerevent.dart';
import 'package:rub_yang/Pages/forgotpassw.dart';
import 'package:rub_yang/Pages/listtab.dart';
import 'package:rub_yang/Pages/farmerform.dart';
import 'package:rub_yang/Pages/login.dart';
// import 'package:rub_yang/Pages/liststore.dart';
// import 'package:rub_yang/Pages/managestore.dart';
import 'package:rub_yang/Pages/notipay.dart';
import 'package:rub_yang/Pages/register.dart';
import 'package:rub_yang/Pages/timeslot.dart';
// import 'package:rub_yang/Pages/timeslot.dart';
import 'package:rub_yang/facview/fachistory.dart';
import 'package:rub_yang/facview/formtofactory.dart';
import 'package:rub_yang/facview/orderfactory.dart';
import 'package:rub_yang/facview/statusfactory.dart';
import 'package:rub_yang/firebase_options.dart';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
// import 'package:rub_yang/storeview/confirmbk.dart';
// import 'package:rub_yang/storeview/confirmorder.dart';
// import 'package:rub_yang/model/storemodel.dart';
// import 'package:rub_yang/storeview/StoreDetail.dart';
import 'package:rub_yang/storeview/displaystore.dart';
import 'package:rub_yang/storeview/formrubyang.dart';
// import 'package:rub_yang/storeview/namestore.dart';
import 'package:rub_yang/storeview/payment.dart';
import 'package:rub_yang/storeview/pricevalue.dart';
import 'package:rub_yang/Pages/home_r.dart';
import 'package:rub_yang/Pages/landing.dart';
import 'package:rub_yang/Pages/formtrade.dart';
// import 'package:rub_yang/Pages/confirmorder.dart';
import 'package:rub_yang/Pages/type_spotf.dart';
import 'package:rub_yang/facview/homefac.dart'; 
import 'package:rub_yang/storeview/homestore.dart';
import 'package:rub_yang/storeview/storedetail_Form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Isrubyang001',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderRequestModel(),
        ),
       ChangeNotifierProvider(
             create: (context) => StoresProvider(),
        ),    
        ChangeNotifierProvider(
          create: (context) => SelectedDateTimeProvider(),
        ),
        //  ChangeNotifierProvider(
        //   create: (context) => StoreSelected(),
        // ),
      ],
      child: const MyApp(),
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
      initialRoute: '/0',
      routes: {
        '/home': (context) => HomePageR(),
        // '/1': (context) => ListStore(),
        '/1':(context) => DisplayStore(),
        // '/2': (context) => ConfirmBooking(),
        '/3': (context) => PriceValue(),
        '/7': (context) => PriceValue(),
        '/4': (context) => FarmerForm(),
        'spot_f': (context) => Spot_F(),
        'formtrade':(context) => Formtrade(),
        '/homestore':(context) => HomeStore(  
                           storeName: 'ชื่อร้าน',
                          dailyPrice: 50, ),
        '/8':(context) => HomeFactory(),
        '/9':(context) => LandingPage(),
        '/10':(context)=> ListTab(),
        '/11': (context) => Farmer_Infor(),
        '/12':(context) => formfactory(),
        '/13':(context) =>Orderfactory(),
        // '/14':(context) =>ConfirmBK(
        //                   storeName: 'ชื่อร้าน',
        //                   dailyPrice: 50, 
        //                 ),
        // '/5':(context) => StatusOrder(),
        '/notipay':(context)=> NotiPay(),
        '/fachistory': (context) => FacHistory(),
        '/farmerevent': (context) => FarmerEvent(),
        '/statusFac': (context) =>StatusFac(),
       '/5': (context) => displayprice(),
       '/Myformstore': (context) => Form_Store(),
       '/0':(context) =>LoginPage(),
       '/register':(context) => RegisterPage(),
       '/forgotpw': (context) => ForgotPasswordPage(),
      //  '/2': (context) => ConfirmBK(
      //                     storeName: 'ชื่อร้าน',
      //                     dailyPrice: 50, 
      //                   ),
       'payment' :(context) => PaymentSelection(),
       'cal' : (context) => Formrubyang(
                              dailyPrice:
                                  50, 
                            ),
        // '/6': (context) => ManageStore(),
        //  '/6': (context) => Store_Detail(),
      },
    );
  }
}
