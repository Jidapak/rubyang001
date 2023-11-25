import 'package:flutter/material.dart';

class GroupChat extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('สมาชิก'),
          titleTextStyle: 
          TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.question_answer,
                  color: Colors.black87,
                ),
                text: 'ถาม-ตอบ',
              ),
              Tab(
                icon: Icon(
                  Icons.group,
                  color: Colors.black87,
                ),
                text: 'กลุ่มแชท',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
           Expanded(
            child: 
            TabBarView(
             children: [
            Center(
            child: Text(
            'ถามตอบ',
               style: TextStyle(
              fontSize: 20,
             color: Colors.white,
               ),
              ),
            ),
           Center(
            child: Text(
              'ห้องแชท',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
           ),
         ],
        ),
      ),
    );
  }
}
