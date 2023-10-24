import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              onPressed: ()  {
                Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                        type: 'gender',
                        choices: ['Female',
                        'Male',
                        'N','LGBTQ'],
                      ),
                    ),
                  );
              },
              child:Consumer<PreferenceModel>(
                builder : (context,value,child){
                return Text("Select your gender - ${ _gender}");
         },
       ),
      ),
          ElevatedButton(
              onPressed: ()  {
                 Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                        type: 'favColor',
                        choices: ['Red',
                        'Yellow',
                        'Green'],
                      ),
                    ),
                  );
                  },
                  child: Consumer<PreferenceModel>(
                    builder:(context,value,child){
                return Text("Select your color - ${_favColor}");
                    },
                    ),
                 ),
             
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                    MaterialPageRoute(
                      builder: (context) => PreferencePage(
                       type: 'Pet',
                        choices: ['Dog',
                        'Cat',
                        'Rabbit'],
                      ),
                    ),
                  );
                  },
                  child: Consumer<PreferenceModel>(
                    builder:(context,value,child){
                return Text("Select your pet - ${_pet}");
              },
      ),
  ),
  ]
    ),
    );
  }
}
class PreferencePage extends StatelessWidget {
final List<String> choices ;
final String type;

const PreferencePage({super.key,required this.type, required this.choices});
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
                  if(type== 'gender'){
                    context.read<PreferenceModel>().gender = choices[index];
                  }
                  if(type=='favColor'){
                    context.read<PreferenceModel>().favColor = choices[index];
                  }
                  if(type=='pet'){
                    context.read<PreferenceModel>().pet = choices[index];
                  }
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
class PreferenceModel extends ChangeNotifier {
String _gender = '';
String _favColor='';
String _pet = '';
 get gender => this._gender;
 set gender(value) {
this._gender = value;
notifyListeners();
 } 

 get favColor => this._favColor;
 set favColor(value){
 this._favColor = value;
notifyListeners();
 } 

 get pet => this._pet;
 set pet(value) {
  this._pet = value;
  notifyListeners();
 } 
}

 