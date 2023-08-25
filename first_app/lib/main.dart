import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hello Flutter'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
    int _counter1 = 0;
    num _counter2=1;
    
  void _incrementCounter() {
    setState(() {  
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {  
      _counter--;
    });
  }
   void _incrementCounter1(){
    setState(() {
      _counter1++;
    });
   }
    void _decrementCounter1(){
      setState(() {
        _counter1--;
      });
    }
    void _MultimentCounter(){
      setState(() {
      _counter2*=2;
      });
    }
    void _DividentCounter(){
      setState(() {
        _counter2/=2;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
                ElevatedButton(
                  onPressed: _incrementCounter,
                   child: Text('+++'),
                   ),
                   ElevatedButton(
                    onPressed:_decrementCounter, 
                    child: Text('---'),
                    )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
              '$_counter1',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                    onPressed:_decrementCounter1, 
                    child: Text('---'),
                    ),
                ElevatedButton(
                  onPressed: _incrementCounter1,
                   child: Text('+++'),
                   ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
              '$_counter2',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                    onPressed:_MultimentCounter,
                    child: Text('****'),
                    ),
                ElevatedButton(
                  onPressed:_DividentCounter,
                   child: Text('////'),
                   ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}