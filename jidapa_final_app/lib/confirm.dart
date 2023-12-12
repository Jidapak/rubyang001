import 'package:flutter/material.dart';
import 'package:jidapa_final_app/bookingpage.dart';
import 'package:jidapa_final_app/model/bkmodel.dart';
import 'package:jidapa_final_app/servicce/bkservice.dart';
import 'package:provider/provider.dart';

class BookingListPage extends StatefulWidget {
  @override
  _BookingListPageState createState() => _BookingListPageState();
}
class _BookingListPageState extends State<BookingListPage> {
  late Future<List<Booking>> bookingFuture;
  @override
  void initState() {
    super.initState();
    bookingFuture = Booking_Service().fetchBooking();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Movies'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: bookingFuture,
        builder: (context, snapshot) {
          if (
            snapshot.connectionState == ConnectionState.waiting
            ) {
            return Center(
              child: CircularProgressIndicator()
              );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(' ${snapshot.error}')
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
              print(snapshot.data);
                Booking bookings = snapshot.data![index];
                return bookingList(bookings: bookings);
              },
            );
          }
        },
      ),
    );
  }
}
class bookingList extends StatelessWidget {
  final Booking bookings;
  const bookingList({Key? key, required this.bookings}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<BookingProvider>(context, listen: false)
            .setListBooking(bookings);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingApp(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white, 
            width: 2, 
          ),
          borderRadius: BorderRadius.circular(8), 
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'movieID: ${bookings.movieID}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'time: ${bookings.time}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'userId: ${bookings.userID}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}