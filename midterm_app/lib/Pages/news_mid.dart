import 'package:flutter/material.dart';

class news_mid extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text('Tabbar'),
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
