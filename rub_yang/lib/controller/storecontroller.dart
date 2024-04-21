import 'dart:async';
import 'package:rub_yang/model/storemodel.dart';
import 'package:rub_yang/service/storeservice.dart';

class StoreController {
  final StoreService _storeService = StoreService(); 
  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Store>> fetchStores() async {
    print('fetchStores is called');
    onSyncController.add(true);
    try {
      List<Store> stores = await _storeService.fetchStores();
      print(stores);
      onSyncController.add(false);
      return stores;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<Store> addStore(Map<String, dynamic> newStoreData) async {
    print('addStore is called');
    onSyncController.add(true);
    try {
      Store addedStore = await _storeService.addStore(newStoreData);
      print(addedStore);
      onSyncController.add(false);
      return addedStore;
    } catch (e) {
      print("Error adding store: $e");
      onSyncController.add(false);
      throw e; // Re-throwing the error for the caller to handle
    }
  }

  Future<Store> updateStore(
      String storeId, Map<String, dynamic> updatedStoreData) async {
    print('updateStore is called');
    onSyncController.add(true);
    try {
      Store updatedStore = await _storeService.updateStore(storeId, updatedStoreData);
      print(updatedStore);
      onSyncController.add(false);
      return updatedStore;
    } catch (e) {
      print("Error updating store: $e");
      onSyncController.add(false);
      throw e; // Re-throwing the error for the caller to handle
    }
  }
}
