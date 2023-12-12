import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jidapa_final_app/model/bkmodel.dart';

abstract class BookingService {
  Future<List<Booking>> fetchBooking();
  void updateBooking(Booking bookings);
}
class Booking_Service implements BookingService {
  @override
  Future<List<Booking>> fetchBooking() async {
    print("fetchBooking is called");
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('jidapa_schedules')
        .get(); 
    print("Booking: ${qs.docs.length}");
    AllBooking booking = AllBooking.fromSnapshot(qs);
    print(booking.booking);
    return booking.booking;
  }
  @override
  void updateBooking(Booking booking) async {
    try {
      await FirebaseFirestore.instance
          .collection('jidapa_schedules') 
          .doc(booking.id)
          .set(booking.toMap());
      print('Booking updated successfully');
    } catch (e) {
      print("Error updating booking: $e");
    }
  }
}
