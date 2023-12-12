import 'dart:async';
import 'package:jidapa_final_app/model/bkmodel.dart';
import 'package:jidapa_final_app/servicce/bkservice.dart';

class BookingController {
  List<Booking> booking = List.empty();
  final BookingService service;

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  BookingController(this.service);

  Future<List<Booking>> fetchBooking() async {
    print(
      "fetchBooking was: $booking"
      );
    onSyncController.add(true);
    booking = await service.fetchBooking();
    onSyncController.add(false);
    return booking;
  }
    void updateBooking(Booking bookings) async {
    service.updateBooking(bookings);
  }
}