import 'package:flutter/material.dart';

class Knowledge extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('ข่าวสาร&ความรู้'),
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
                  Icons.newspaper,
                  color: Colors.black87,
                ),
                text: 'ข่าวสาร',
              ),
              Tab(
                icon: Icon(
                  Icons.emoji_objects,
                  color: Colors.black87,
                ),
                text: 'ความรู้',
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
            'เนื้อหาข่าวสาร ',
               style: TextStyle(
              fontSize: 20,
             color: Colors.white,
               ),
              ),
            ),
           Center(
            child: Text(
              'เนื้อหาความรู้',
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
