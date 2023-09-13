import 'package:flutter/material.dart';
class FifthPage extends StatefulWidget {
  @override
  State<FifthPage> createState() => _FifthPageState();
}
class _FifthPageState extends State<FifthPage> {
  String _gender = '';
  String _favColor='';
  String _pet = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fifth Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () async {
                var choices = await Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                        choices: ['Female',
                        'Male',
                        'N','LGBTQ'],
                      ),
                    ),
                  );
                  setState(() {
                    _gender = choices;
                  });
              },
              child: Text("Select your gender - ${_favColor}")),
              
          ElevatedButton(
              onPressed: () async {
                var choices = await Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                        choices: ['Red',
                        'Yellow',
                        'Green'],
                      ),
                    ),
                  );
                  setState(() {
                    _gender = choices;
                  });
              },
              child: Text("Select your colour - ${_gender}")),
          ElevatedButton(
              onPressed: () async {
                var choices = await Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                        choices: ['Dog',
                        'Cat',
                        'Rabbit'],
                      ),
                    ),
                  );
                  setState(() {
                    _gender = choices;
                  });
              },
              child: Text("Select your pet - ${_pet}")),
        ],
      ),
    );
  }
}
class PreferencePage extends StatelessWidget {
final List<String> choices ;
const PreferencePage({super.key, required this.choices});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("select your preference"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: 
            ListView.builder(
              itemCount: choices.length,
              itemBuilder: (context,index){
                return ElevatedButton(
                onPressed: (){
                  Navigator.pop(context,choices[index]);
                },
                child: Text('${choices[index]}'),
                );
              },
         ),
      ),
    );
  }
}
class PreferenceDetails {}

 