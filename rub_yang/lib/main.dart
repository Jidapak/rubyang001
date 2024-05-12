import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
// import 'package:rub_yang/Pages/aboutpdf/addreport1.dart';
import 'package:rub_yang/Pages/aboutpdf/edittoreport.dart';
import 'package:rub_yang/Pages/aboutpdf/homereport.dart';
// import 'package:rub_yang/Pages/bookingsceen.dart';
// import 'package:rub_yang/Pages/detail.dart';
// import 'package:rub_yang/Pages/detail2.dart';
import 'package:rub_yang/Pages/displayprice.dart';
import 'package:rub_yang/Pages/farmerInfor.dart';
import 'package:rub_yang/Pages/farmerevent.dart';
import 'package:rub_yang/Pages/listorderreq.dart';
import 'package:rub_yang/Pages/listtab.dart';
import 'package:rub_yang/Pages/farmerform.dart';
import 'package:rub_yang/Pages/login.dart';
// import 'package:rub_yang/Pages/liststore.dart';
// import 'package:rub_yang/Pages/managestore.dart';
import 'package:rub_yang/Pages/notipay.dart';
import 'package:rub_yang/Pages/ordersend.dart';
import 'package:rub_yang/Pages/register.dart';
import 'package:rub_yang/Pages/timeslot.dart';
// import 'package:rub_yang/Pages/timeslot.dart';
import 'package:rub_yang/facview/fachistory.dart';
import 'package:rub_yang/facview/formtofactory.dart';
import 'package:rub_yang/facview/listkanyang.dart';
import 'package:rub_yang/facview/orderfactory.dart';
import 'package:rub_yang/facview/statusfactory.dart';
import 'package:rub_yang/firebase_options.dart';
import 'package:rub_yang/loginrole/forgotpassw.dart';
import 'package:rub_yang/loginrole/login_pagerole.dart';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/storeview/confirmbk.dart';
// import 'package:rub_yang/storeview/confirmbk.dart';
// import 'package:rub_yang/storeview/confirmorder.dart';
// import 'package:rub_yang/model/storemodel.dart';
// import 'package:rub_yang/storeview/StoreDetail.dart';
import 'package:rub_yang/storeview/displaystore.dart';
import 'package:rub_yang/storeview/formrubyang.dart';
import 'package:rub_yang/storeview/ordercusto.dart';
// import 'package:rub_yang/storeview/namestore.dart';
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
         ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

num selectedPrice = 0;
final String selectedStoreName = "";
final num priceSheets = 0;
 final DateTime selectedDate = DateTime.now();
  final String selectedTime="";
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
        '/1': (context) => DisplayStore(),
        '/2': (context) => OrderSend(),
        '/3': (context) => PriceValue(),
        '/7': (context) => PriceValue(),
        '/4': (context) => FarmerForm(),
        'spot_f': (context) => Spot_F(),
        'formtrade': (context) => Formtrade(),
        '/homestore': (context) => HomeStore(
            priceSheets: priceSheets,
              selectedStoreName: selectedStoreName,
            ),
        '/8': (context) => HomeFactory(),
        '/9': (context) => LandingPage(),
        '/10': (context) => ListTab(
              priceSheets: priceSheets,
              selectedStoreName: selectedStoreName,
            ),
        '/11': (context) => Farmer_Infor(),
        '/12': (context) => FormFactory(),
        '/13': (context) => Orderfactory(),
        // '/14':(context) =>ConfirmBK(
        //                   storeName: 'ชื่อร้าน',
        //                   dailyPrice: 50,
        //                 ),
        // '/5':(context) => StatusOrder(),
        '/fachistory': (context) => FacHistory(),
        '/farmerevent': (context) => Factory_Infor(),
        '/statusFac': (context) => StatusFac(),
        '/5': (context) => displayprice(),
        '/Myformstore': (context) => Form_Store(),
        '/0': (context) => Login_Page(),
        //  '/0':(context) =>LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgotpw': (context) => ForgotPasswordPage(),
        //  '/2': (context) => ConfirmBK(
        //                     priceSheets: priceSheets,
        //       selectedStoreName: selectedStoreName,
        //                   ),
        // 'cal': (context) => Formrubyang(
        //       priceSheets: priceSheets,
        //       selectedStoreName: selectedStoreName,
        //       // selectedDate: selectedDate,

        //     ),
        '/6': (context) => ListKanyang(),
        //  'cust': (context) => OrderCust( 
        //   priceSheets: priceSheets[0],
        //               selectedStoreName: selectedStoreName,),
        //  '/6': (context) => Store_Detail(),
      },
    );
    
  }
}
  //  Route<dynamic>? _handleRouteWithParameters(RouteSettings settings) {
  //   if (settings.name == '/editNote') {
  //     final docSnapshot = settings.arguments as DocumentSnapshot;
  //     return MaterialPageRoute(
  //       builder: (context) => editnote(docid: docSnapshot),
  //     );
  //   }
  //   // Handle other special routes or return null
  //   return null;
  // }
// }