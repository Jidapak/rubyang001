import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StatusFac extends StatefulWidget{
  const StatusFac({super.key});

@override
State<StatusFac> createState() => _StatusFacState();
}
class _StatusFacState extends State<StatusFac>{
    @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(
          'สถานะการส่งโรงงาน',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
     ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTimelineTile(
              isFirst: true,
              isLast: false,
              isPast: true,
              eventCard: Text(
                "กำลังส่งโรงงาน",
                style: const TextStyle(
                   color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            MyTimelineTile(
              isFirst: false,
              isLast: false,
              isPast: true,
              eventCard: Text(
                "รอโรงงานตรวจสอบ",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MyTimelineTile(
              isFirst: false,
              isLast: true,
              isPast: false,
              eventCard: Text(
                "โรงงานโอนยอดเงิน",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 class MyTimelineTile extends StatelessWidget{
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final eventCard;

  const MyTimelineTile({
    super.key,
  required this.isFirst,
  required this.isLast,
  required this.isPast,
  required this.eventCard,
    });
  @override
  Widget build(BuildContext context){
  return SizedBox(
  height: 200,
  child: TimelineTile(
   isFirst: isFirst,
   isLast: isLast,
   beforeLineStyle: LineStyle(
    color :isPast? Colors.brown : Color.fromARGB(255, 171, 143, 132),
   ),
   indicatorStyle: IndicatorStyle(
    color :isPast? Colors.brown : Color.fromARGB(255, 171, 143, 132),
    width: 40,
    iconStyle: IconStyle(
      iconData: Icons.done,
      color :isPast? Colors.white : Color.fromARGB(255, 171, 143, 132),
   ),
  ),
  endChild: EventCard(
    isPast: isPast,
    child: eventCard,
  ),
  ),
  );
  }
  }
 class EventCard extends StatelessWidget {
  final bool isPast;
  final Widget child;

  const EventCard({
    Key? key,
    required this.isPast,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: isPast? Colors.brown: Color.fromARGB(255, 171, 143, 132),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}