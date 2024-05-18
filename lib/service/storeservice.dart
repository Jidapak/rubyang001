import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rub_yang/model/storemodel.dart';

class StoreService {
  Future<List<Store>> fetchStores() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('prices').get();

      print("Stores in Firebase count: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Store.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching stores: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<Store> addStore(Map<String, dynamic> newStoreData) async {
    try {
      DocumentReference ref =
          await FirebaseFirestore.instance.collection('prices').add(newStoreData);

      // Fetch the newly added document
      DocumentSnapshot newDoc = await ref.get();
      return Store.fromJson(newDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error adding store: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<Store> updateStore(
      String storeId, Map<String, dynamic> updatedStoreData) async {
    try {
      DocumentReference storeRef =
          FirebaseFirestore.instance.collection('prices').doc(storeId);

      // Update the document
      await storeRef.update(updatedStoreData);

      // Fetch the updated document
      DocumentSnapshot updatedDoc = await storeRef.get();
      return Store.fromJson(updatedDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error updating store: $e");
      throw e;
    }
  }
}