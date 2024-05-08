import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Store {
  
  String id = "";
  // late num daily_price;
  // late num price_difference;
  late String id_store;
  late String name_store;
  late num update_pricechunk;
  late num update_pricewater;
  late num update_pricesheet;
  late Timestamp today_date;
  // status
  
  Store(
    this.id,
    // this.daily_price,
    // this.price_difference,
    this.id_store,
    this.name_store,
    this.update_pricechunk,
    this.update_pricesheet,
    this.update_pricewater,
    this.today_date,
  );

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      json['id'] as String? ?? '', // Check for null before casting to String
      // json['daily_price'] as num? ?? 0,
      // json['price_difference'] as num? ?? 0,
      json['id_store'] as String? ?? '',
      json['name_store'] as String? ?? '',
      json['update_pricechunk'] as num? ?? 0,
      json['update_pricesheet'] as num? ?? 0,
      json['update_pricewater'] as num? ?? 0,
      json['today_date'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_store' : name_store,
      // 'dailyprice': daily_price,
      // 'differprice': price_difference,
      'id_store': id_store,
      'update_pricesheet': update_pricesheet,
      'update_pricechunk': update_pricechunk,
      'update_pricewater': update_pricewater,
      'today_date': today_date,
    };
  }

  String toString() {
    return 'Store{id: $id, id_store: $id_store,name_store:$name_store ,update_pricewater: $update_pricewater, update_pricechunk: $update_pricechunk, update_pricesheet: $update_pricesheet, today_date: $today_date}';
  }
}

class AllStores {
  final List<Store> stores;

  AllStores(this.stores);

  factory AllStores.fromJson(List<dynamic> json) {
    List<Store> stores = json.map((item) => Store.fromJson(item)).toList();
    return AllStores(stores);
  }

  factory AllStores.fromSnapshot(QuerySnapshot qs) {
    List<Store> stores = qs.docs.map((DocumentSnapshot ds) {
      Map<String, dynamic> dataWithId = ds.data() as Map<String, dynamic>;
      dataWithId['id'] = ds.id;
      return Store.fromJson(dataWithId);
    }).toList();
    return AllStores(stores);
  }

  Map<String, dynamic> toJson() {
    return {
      'stores': stores.map((store) => store.toJson()).toList(),
    };
  }
}

class StoresProvider extends ChangeNotifier {
  List<Store>? _allStores = [];

  List<Store>? get allStores => _allStores;

  void setStores(List<Store>? stores) {
    _allStores = stores;
    notifyListeners();
  }

  void addStore(Store store) {
    print("addStore @ provider is called");
    _allStores!.add(store);
    notifyListeners();
  }

  void updateStore(Store updatedStore) {
    print("updateStore @ provider is called");
    int index = _allStores!.indexWhere((store) => store.id == updatedStore.id);
    if (index != -1) {
      _allStores![index] = updatedStore;
      notifyListeners();
    }
  }
}
