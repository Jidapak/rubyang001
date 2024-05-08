// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FarmerData {
//   String id = "";
//   String namefarmer = '';
//   String lastnfarmer = '';
//   String nationality = '';
//   num areafarm = 0;
//   num quantitytree = 0;
//   num agetree = 0;
//   String location = '';
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   String telnum = '';
//   bool isPhoneValidated = false;
//   String _radioValue11 = '';
//   String _radioValue12 = '';
//  FarmerData(
//   this.id,
//   this.namefarmer,
//   this.lastnfarmer,
//   this.nationality,
//   this.areafarm,
//   this.quantitytree,
//   this.agetree,
//   this.location ,
//   this.selectedCountry,
//   this.selectedState,
//   this.selectedCity,
//   this.telnum ,
//   this.isPhoneValidated ,
//   this._radioValue11,
//   this._radioValue12,
//   );
//   factory FarmerData.fromJson(Map<String, dynamic> json) {
//     return FarmerData(
//       json['id'] as String? ?? '',
//       json['namefarmer'] as String? ?? '',
//       json['lastnfarmer'] as String? ?? '',
//       json['nationality'] as String? ?? '',
//       json['areafarm'] as num? ?? 0,
//       json['quantitytree'] as num? ?? 0,
//       json['agetree']as num? ?? 0,
//       json['location'] as String? ?? '',
//       json['selectedCountry'] as String? ?? '',
//       json['selectedState'] as String? ?? '',
//       json['selectedCity'] as String? ?? '',
//       json['telnum'] as String? ?? '',
//       json['isPhoneValidated'] as bool? ?? false,
//       json['_radioValue11'] as String? ??'',
//       json['_radioValue12'] as String? ??'',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
  //        'id': id,
  //  'namefarmer' : namefarmer,
  //  'lastnfarmer' : lastnfarmer,
  //  'nationality' :nationality,
  //  'areafarm' : areafarm,
  //  'quantitytree' : quantitytree,
  //  'agetree' : agetree,
  //  'location' : location ,
  //  'selectedCountry' : selectedCountry,
  //  'selectedState' : selectedState,
  //  'selectedCity' : selectedCity,
  //   'telnum ' : telnum ,
  //   'isPhoneValidated' : isPhoneValidated ,
  //   '_radioValue11':_radioValue11,
  //   '_radioValue12':_radioValue12,
//     };
//   }

//   String toString() {
//     return 'FarmerData{id: $id, namefarmer: $namefarmer, lastnfarmer: $lastnfarmer, nationality: $nationality, areafarm: $areafarm, quantitytree: $quantitytree,agetree: $agetree, location : $location ,selectedCountry: $selectedCountry, selectedState:$selectedState, selectedCity:$selectedCity, telnum: $telnum,isPhoneValidated: $isPhoneValidated, _radioValue11:$_radioValue11 ,_radioValue11:$_radioValue11}';
//   }
// }

// class AllFarmers {
//   final List<FarmerData> farmers;

//    AllFarmers(this.farmers);

//   factory  AllFarmers.fromJson(List<dynamic> json) {
//     List<FarmerData> farmers = json.map((item) =>FarmerData.fromJson(item)).toList();
//     return  AllFarmers(farmers);
//   }

//   factory  AllFarmers.fromSnapshot(QuerySnapshot qs) {
//     List<FarmerData> farmers = qs.docs.map((DocumentSnapshot ds) {
//       Map<String, dynamic> dataWithId = ds.data() as Map<String, dynamic>;
//       dataWithId['id'] = ds.id;
//       return FarmerData.fromJson(dataWithId);
//     }).toList();
//     return  AllFarmers(farmers);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'farmers':farmers.map((farmer) => farmer.toJson()).toList(),
//     };
//   }
// }

// class FarmersProvider extends ChangeNotifier {
//   List<FarmerData>? _allFarmers = [];

//   List<FarmerData>? get allFarmers => _allFarmers;

//   void setFarmers(List<FarmerData>? farmers) {
//     _allFarmers = farmers;
//     notifyListeners();
//   }

//   void addFarmer(FarmerData farmer) {
//     print("addStore @ provider is called");
//     _allFarmers!.add(farmer);
//     notifyListeners();
//   }

//   void updateFarmer(FarmerData updatedFarmer) {
//     print("updateFarmer @ provider is called");
//     int index = _allFarmers!.indexWhere((store) => store.id == updatedFarmer.id);
//     if (index != -1) {
//       _allFarmers![index] = updatedFarmer;
//       notifyListeners();
//     }
//   }
// }
