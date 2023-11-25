import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details(
      {Key? key, required this.PName, required this.PDescription})
      : super(key: key);
  String PName, PDescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'Surat_Rubyang',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
        body: Container(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                  width: 4.0, 
                  color: Colors.black
                  ),
                  ),
                  leading: IconButton(
                  icon: const Icon(Icons.bookmark_added_rounded,
                  color: Colors.black
                  ),
                  onPressed: () {},
                ),
                title: Text(
                  PName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 18.0
                  ),
                ),
                subtitle: Text(PDescription),
                trailing: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
           ],
        ),
      )
    );
  }
}

 