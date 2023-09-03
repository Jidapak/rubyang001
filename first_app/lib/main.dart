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
      initialRoute:'/first' ,
      routes : {
      '/first': (context) => FirstPage(),
      '/second': (context) => SecondPage(),
      '/third': (context) => ThirdPage(),
      },
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
            SizedBox(
              width:100.0 ,
            child: Image.asset('images/bojung.jpg'),
            ),
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

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('First Page'),
        actions: [
          IconButton(onPressed:(){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hello ...'),
                ),
            );
          }, 
          icon: Icon(Icons.add_alert), 
          ),
          IconButton(onPressed:(){
            Navigator.pushNamed(context, '/second');
          }, 
          icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
      body: Center(
        child: Image.network ('https://i.pinimg.com/564x/57/52/01/5752016f1311cf6624af3da7266cb2db.jpg'
        ),
      ),
    );
  } 
}
class SecondPage extends StatelessWidget{
  final List<String> entries = ['A','B','C','D','E'];
  final List<int> colorCodes =[600, 500,400,300,100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Second Page'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/third');
            },
           icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
      body: ListView.separated(
        padding:const EdgeInsets.all(12.0),
        itemBuilder: (context, index ){
          return Container(
            height: 150.0 ,
            color: Colors.green[colorCodes[index]],
            child: Center(
              child:Text('Item ${entries[index]}'),
               ),
          );
        },
        separatorBuilder:(context, index ) => Divider() ,
        itemCount: entries.length,
        ),
      );
  }
}
class ThirdPage extends StatelessWidget{
   final List<String> imagePaths=[
  'images/babyPolar.png',
  'images/Poling.png',
    'images/Maru.png',
    'images/Sushi.png',
    'images/Polar.png',
    'images/Fatmuji.png',
    'images/Poli.png',
    'images/Tonhom.png',
    'images/Yumi.png',
     'images/Muji.png',
   ];
   final List<String> entries = ['A','B','C','D','E','F','G','H','I','J'];
  final List<int> colorCodes =[500,300,500,300,500,300,500,300,500,300,500,300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Third Page'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, 'Flutter Demo');
            },
           icon: Icon(Icons.navigate_next),
          ),
        ],
      ) ,
       body: ListView.separated(
         padding:const EdgeInsets.all(10.0),
          itemBuilder: (context, index ){
          return Container(
          color: Colors.green[colorCodes[index]],
          child : Image.asset(
              imagePaths[index],
              width: 150.0, // Set the desired width for each image
              height: 150.0,
          ),
          );
          },    
        itemCount: imagePaths.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(); // Add a separator between images
        },
        ),
      );
  } 
}