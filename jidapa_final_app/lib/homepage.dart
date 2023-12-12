import 'package:flutter/material.dart';
import 'package:jidapa_final_app/listpage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Column(
                      children: [
                        Text(
                          "hello member",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "What to Watch",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "images/bear.png",
                    height: 60,
                    width: 60,
                    ),
                    ), 
                  ],
                ),
              ),
              SizedBox(height: 30),
              listmovie(), 
              SizedBox(height: 40),
              MovieTheater(),
            ],
          ),
        ),
      ),
    );
  }
}
class listmovie  extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Column(
  children: [
    Padding(
    padding:EdgeInsets.symmetric(horizontal:10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "New Movies",
          style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
             ),
            ),
          ],
        ), 
       ),
       SizedBox(height: 15),
       SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      children: [
        for(int i=1; i<4 ;i++)
         Padding(
          padding:EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius:BorderRadius.circular(15),
          child: Image.asset(
            "images/M$i.jpg",
            height: 180,
            width:300,
            fit: BoxFit.cover,
          ), 
          ), 
         ),
         ],
        ),
       ),
      ],
     );
   }
  }
  class MovieTheater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommend Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6
                    ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white, width: 2
                      ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 350,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(),
                        child: Image.asset(
                          "images/M4.jpg",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title: Mermaid",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "genre: fantacy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

