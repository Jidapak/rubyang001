// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// Future<UserModel> getUserProfile(BuildContext context,String phone) async{
//   CollectionReference userRef = FirebaseFirestore.instance.collection('User')
//   DocumentSnapshot snapshot = await userRef.doc(phone).get();
//   if(snapshot.exists){
//     var userModel =UserModel.fromJson(snapshot.data());
//     context.read(UserInformation) =userModel ;
//     return userModel; 
//   } else
//   return UserModel();
// }