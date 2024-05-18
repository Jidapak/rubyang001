import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rub_yang/Pages/timeslot.dart';
import 'package:rub_yang/controller/storecontroller.dart';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/storeview/formrubyang.dart';

class NameStore extends StatefulWidget {
  final String selectedStoreName;
  NameStore({required this.selectedStoreName});
  @override
  _NameStoreState createState() => _NameStoreState();
}

class _NameStoreState extends State<NameStore> {
  List<Store> stores = List.empty();
  bool isLoading = false;
  StoreController _storeController = StoreController();
  List<String> selectedPrice = [];
  List<num> priceSheets=[];
String? selectedRubberType; 
  @override
  void initState() {
    super.initState();
    _getStores();
  }
  void _getStores() async {
    print('_getStores start');
    var newStoreData = await _storeController.fetchStores();
    print(newStoreData.length);
    stores = newStoreData;
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      StoresProvider storesProvider = context.read<StoresProvider>();
      storesProvider.setStores(stores);
    });

    // priceSheets = selectedPrice.map((price) => num.tryParse(price) ?? 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ร้านรับซื้อ',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: context.watch<StoresProvider>().allStores?.length ?? 0,
              itemBuilder: (context, index) {
                final store = context.watch<StoresProvider>().allStores?[index];
                if (store == null ||
                    store.name_store != widget.selectedStoreName) {
                  // ไม่แสดงร้านที่ไม่ตรงกับที่เลือกมา
                  return Container();
                }
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.store,
                      size: 30,
                      color: Colors.brown,
                    ),
                    title: Text(
                      'ชื่อร้าน:${store.name_store}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile(
                          title: Text(
                            'ราคายางก้อนวันนี้: ${store.update_pricechunk.toString()} บาท',
                            style: TextStyle(fontSize: 16, color: Colors.brown),
                          ),
                          value: store.update_pricechunk.toString(),
                          groupValue: selectedPrice.isNotEmpty
                              ? selectedPrice[0]
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectedPrice.clear();
                              selectedPrice.add(value.toString());
                               selectedRubberType = 'ยางก้อน';
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            'ราคายางแผ่นวันนี้: ${store.update_pricesheet.toString()} บาท',
                            style: TextStyle(fontSize: 16, color: Colors.brown),
                          ),
                          value: store.update_pricesheet.toString(),
                          groupValue: selectedPrice.isNotEmpty
                              ? selectedPrice[0]
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectedPrice.clear();
                              selectedPrice.add(value.toString());
                                selectedRubberType = 'ยางแผ่น';
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            'ราคายางน้ำวันนี้: ${store.update_pricewater.toString()} บาท',
                            style: TextStyle(fontSize: 16, color: Colors.brown),
                          ),
                          value: store.update_pricewater.toString(),
                          groupValue: selectedPrice.isNotEmpty
                              ? selectedPrice[0]
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectedPrice.clear();
                              selectedPrice.add(value.toString());
                                selectedRubberType = 'น้ำยาง';
                            });
                          },
                        ),
                        Center(
                          child: FloatingActionButton(
                            onPressed: () {
                              print("Price $selectedPrice");
                              print("product type is pressed $priceSheets");
                              if (selectedPrice.isNotEmpty) {
                                List<num> selectedNumbers = selectedPrice.map((string) => num.parse(string)).toList();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TimeSlot(
                                      priceSheets: selectedNumbers,
                                       selectedStoreName: widget.selectedStoreName,
                                       rubberType: selectedRubberType,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// class AddStorePage extends StatefulWidget {
//   @override
//   _AddStorePageState createState() => _AddStorePageState();
// }

// class _AddStorePageState extends State<AddStorePage> {
//   final _formKey = GlobalKey<FormState>();
//   String id_store = '';
//   num dailyprice = 0;
//   StoreController _storeController = StoreController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Store'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Store Name'),
//                 onSaved: (value) =>
//                     id_store = value!, // Change brand to id_store
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a store name' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => dailyprice =
//                     num.tryParse(value!) ?? 0, // Change price to dailyprice
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a price' : null,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();

//                     // call controller
//                     Store? newStore = await _storeController.addStore({
//                       "id_store": id_store,
//                       "dailyprice": dailyprice,
//                     });
//                     print(newStore.toJson());

//                     // adding new Store to state
//                     context.read<StoresProvider>().addStore(newStore);

//                     Navigator.of(context).pop();
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EditStorePage extends StatefulWidget {
//   final Store store;

//   EditStorePage({required this.store});

//   @override
//   _EditStorePageState createState() => _EditStorePageState();
// }

// class _EditStorePageState extends State<EditStorePage> {
//   final _formKey = GlobalKey<FormState>();
//   late String id_store;
//   late num update_pricesheet;
//   late num update_pricechunk;
// late num update_pricewater;

//   StoreController _storeController =
//       StoreController();

//   @override
//   void initState() {
//     super.initState();
//     id_store = widget.store.id_store;
//     update_pricesheet = widget.store.update_pricesheet;
//     update_pricechunk = widget.store.update_pricechunk;
//     update_pricewater = widget.store.update_pricewater;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Store'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 initialValue: id_store,
//                 decoration: InputDecoration(labelText: 'Store Name'),
//                 onSaved: (value) =>
//                     id_store = value!, // Change brand to id_store
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a store name' : null,
//               ),
//               TextFormField(
//                 initialValue: daily_price.toString(),
//                 decoration: InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => daily_price =
//                     num.tryParse(value!) ?? 0,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a price' : null,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();

//                     // call controller
//                     Store? updatedStore =
//                         await _storeController.updateStore(widget.store.id, {
//                       "id_store": id_store,
//                       "dailyprice": daily_price,
//                     });

//                     // update data to state
//                     if (updatedStore != null) {
//                       // Update store in the provider
//                       context.read<StoresProvider>().updateStore(updatedStore);

//                       // Go back to the previous screen
//                       Navigator.of(context).pop();
//                     }
//                   }
//                 },
//                 child: Text('Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StoreProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> _stores = [];
//   get stores => _stores;
//   void addStore({
//     required String namestore,
//     required String update_price,
//   }) {
//     _stores.add({
//       'namestore': '$namestore',
//       'update_price': '$update_price.',
//     });
//     notifyListeners();
//   }
// }

// Future<List<int>> getTimeslotofStore(NameStore namestore, String date) async {
//   List<int> result = [];
//   CollectionReference bookingRef = FirebaseFirestore.instance.collection(date);
//   QuerySnapshot snapshot = await bookingRef.get();
//   snapshot.docs.forEach((element) {
//     result.add(int.parse(element.id));
//   });
//   return result;
// }