import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Booking {
  String id = "";
  late String movieID;
  late Timestamp time;
  late String userID;

  Booking(
    this.movieID,
    this.time,
    this.userID,
  ); 
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      json['movieID'] as String,
      json['time'] as Timestamp,
      json['userID'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'movieID': movieID,
      'time': time,
      'userID': userID,
    };
  }
    @override
  String toString() {
    return 'Booking{movieID: $movieID, time: $time, userID: $userID}';
  }
}
class AllBooking {
  final List<Booking> booking;
  AllBooking(this.booking);
  factory AllBooking.fromJson(List<dynamic> json) {
    List<Booking> booking = json.map((item) => Booking.fromJson(item)).toList();
    return AllBooking(booking);
  }
  factory AllBooking.fromSnapshot(QuerySnapshot qs) {
    List<Booking> booking = qs.docs.map((DocumentSnapshot ds) {
      Booking booking = Booking.fromJson(ds.data() as Map<String, dynamic>);
      booking.id = ds.id;
      return booking;
    }).toList();
    return AllBooking(booking);
  }
}
class BookingProvider with ChangeNotifier {
  Booking? _ListBooking;
  Booking? get ListBooking => _ListBooking;
  void setListBooking(Booking booking) {
    _ListBooking = booking;
    notifyListeners();
  }
}
