import 'package:flutter/material.dart';

class Details2 extends StatelessWidget {
  Details2(
      {Key? key, required this.PName, required this.PDescription})
      : super(key: key);
  String PName, PDescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'ถาม-ตอบข้อสงสัย',
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
                  side: BorderSide(width: 4.0, color: Colors.black)),
                  leading: IconButton(
                  icon: const Icon(
                    Icons.question_answer,
                  color: Colors.black54
                  ),
                  onPressed: () {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Deletion'),
                        content: Text('Are you sure you want to delete this item?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                    );
                  }
                ),
                title: Text(
                  PName,
                  style: const TextStyle(
                    color: Colors.black54,
                      fontWeight: FontWeight.bold, 
                      fontSize: 20.0
                  ),
                ),
                subtitle: Text(
                  PDescription,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0
                  ),
                  ),
                trailing: const Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
              ),
           ],
        ),
      )
    );
  }
}

 