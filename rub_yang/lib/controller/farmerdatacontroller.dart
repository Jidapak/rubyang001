// import 'dart:async';
// import 'package:rub_yang/loginrole/farmer.dart';
// import 'package:rub_yang/model/farmerdatamodel.dart';
// import 'package:rub_yang/model/storemodel.dart';
// import 'package:rub_yang/service/farmerdataservice.dart';

// class FarmerDataController {
//   final FarmerService _farmerService = FarmerService(); 
//   StreamController<bool> onSyncController = StreamController();
//   Stream<bool> get onSync => onSyncController.stream;

//   Future<List<FarmerData>> fetchStores() async {
//     print('fetchFarmers is called');
//     onSyncController.add(true);
//     try {
//       List<FarmerData> farmers = await _farmerService.fetchFarmers();
//       print(farmers);
//       onSyncController.add(false);
//       return farmers;
//     } catch (e) {
//       onSyncController.add(false);
//       throw e;
//     }
//   }

//   Future<FarmerData> addFarmer(Map<String, dynamic> newFarmerData) async {
//     print('addStore is called');
//     onSyncController.add(true);
//     try {
//       FarmerData addedFarmer = await _farmerService.addFarmer(newFarmerData);
//       print(addedFarmer);
//       onSyncController.add(false);
//       return addedFarmer;
//     } catch (e) {
//       print("Error adding store: $e");
//       onSyncController.add(false);
//       throw e; // Re-throwing the error for the caller to handle
//     }
//   }
//   Future<FarmerData> updateFarmer(
//       String farmerId, Map<String, dynamic> updatedFarmerData) async {
//     print('updateFarmer is called');
//     onSyncController.add(true);
//     try {
//       FarmerData updatedFarmer = await _farmerService.updateFarmer(farmerId, updatedFarmerData);
//       print(updatedFarmer);
//       onSyncController.add(false);
//       return updatedFarmer;
//     } catch (e) {
//       print("Error updating farmer: $e");
//       onSyncController.add(false);
//       throw e; 
//     }
//   }
// }