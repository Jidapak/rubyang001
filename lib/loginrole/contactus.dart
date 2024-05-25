import 'package:flutter/material.dart';
class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อเรา',
          style : TextStyle(
          color: Colors.brown[500],
          fontSize: 22,
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          ContactInfoItem(
            assetImagePath: 'icons/phone_icon.jpg', 
            text: 'โทร: 080-123-4567',
          ),
          ContactInfoItem(
            assetImagePath: 'icons/email_icon.jpg', 
            text: 'อีเมล: contact@gmail.com',
          ),
          ContactInfoItem(
            assetImagePath: 'icons/line_icon.png', 
            text: 'ไลน์ไอดี: line_id',
          ),
        ],
      ),
    );
  }
}
class ContactInfoItem extends StatelessWidget {
  final String assetImagePath;
  final String text;

  const ContactInfoItem({
    required this.assetImagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            assetImagePath,
            width:70, 
            height:70, 
          ),
          SizedBox(width: 10.0),
          Text(text,
          style : TextStyle(
          color: Colors.brown[900],
          fontSize: 18,
          ),
          ),
        ],
      ),
    );
  }
}
