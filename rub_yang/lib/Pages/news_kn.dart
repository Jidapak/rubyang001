import 'package:flutter/material.dart';

class News_Kn extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('Tabbar'),
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
              ),
              Tab(
                icon: Icon(
                  Icons.emoji_objects,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
         body: TabBarView(
          children: [
          Center(child: Text('Tab 1 Content'),),
          Center(child: Text('Tab 2 Content'),),
          ],
        ),
      ),
    );
  }
}
