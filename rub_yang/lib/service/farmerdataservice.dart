// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rub_yang/model/farmerdatamodel.dart';

// class FarmerService {
//   Future<List<FarmerData>> fetchFarmers() async {
//     try {
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('prices').get();

//       print("Farmers in Firebase count: ${snapshot.docs.length}");

//       return snapshot.docs.map((doc) => FarmerData.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print("Error fetching farmers: $e");
//       throw e; // rethrow the error for the controller to handle
//     }
//   }

//   Future<FarmerData> addFarmer(Map<String, dynamic> newFarmerData) async {
//     try {
//       DocumentReference ref =
//           await FirebaseFirestore.instance.collection('prices').add(newFarmerData);

//       // Fetch the newly added document
//       DocumentSnapshot newDoc = await ref.get();
//       return FarmerData.fromJson(newDoc.data() as Map<String, dynamic>);
//     } catch (e) {
//       print("Error adding store: $e");
//       throw e; // rethrow the error for the controller to handle
//     }
//   }

//   Future<FarmerData> updateFarmer(
//       String storeId, Map<String, dynamic> updatedStoreData) async {
//     try {
//       DocumentReference storeRef =
//           FirebaseFirestore.instance.collection('prices').doc(storeId);

//       // Update the document
//       await storeRef.update(updatedStoreData);

//       // Fetch the updated document
//       DocumentSnapshot updatedDoc = await storeRef.get();
//       return FarmerData.fromJson(updatedDoc.data() as Map<String, dynamic>);
//     } catch (e) {
//       print("Error updating store: $e");
//       throw e;
//     }
//   }
// }