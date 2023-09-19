import 'package:flutter/material.dart';

class FourthPages extends StatefulWidget {
  @override
  State<FourthPages> createState() => _FourthPagesState();
}

class _FourthPagesState extends State<FourthPages> {
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  String name= '';
  String cardNumber= '';
  String cvv= '';
  String validDate= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Fourth Page'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  hintText: 'PAYMENT DETAILS',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  if (value.length <= 10) {
                    return 'Message must be more than 10 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _message = newValue!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'NAME ON CARD',
                  labelStyle:TextStyle(
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)
                 ),
                  hintText: 'Daniel Hecker',
                  contentPadding:
                      EdgeInsets.symmetric(
                        vertical: 10.0, 
                        horizontal: 10.0
                  ),
                  ),
                 initialValue: 'Daniel Hecker',
                         style: TextStyle(
                         fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'CARD NUMBER',
                  labelStyle:TextStyle(
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  hintText: '4534 5555 5555 5555',
                  contentPadding:
                      EdgeInsets.symmetric(
                        vertical: 10.0, 
                        horizontal: 10.0
                  ),
                ),
                 initialValue: '4534 5555 5555 5555',
                         style: TextStyle(
                         fontWeight: FontWeight.bold,
                         ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1 ,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'cvv',
                          labelStyle:TextStyle(
                          color: Colors.green,
                         ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)
                            ),
                          hintText: '455',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          contentPadding: EdgeInsets.symmetric(
                          vertical: 0, 
                          horizontal: 10,
                          ),
                          hintMaxLines: 2,
                        ),
                         initialValue: '455',
                         style: TextStyle(
                         fontWeight: FontWeight.bold,
                         ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2 ,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'VALID THROUGH',
                          labelStyle:TextStyle(
                          color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)
                            ),
                          hintText: '06/19 ',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, 
                              horizontal: 10.0
                          ),
                          ),
                         initialValue: '06/19',
                         style: TextStyle(
                         fontWeight: FontWeight.bold,
                         ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                     builder: (context) => ConfirmPayment(
                      detail: PaymentDetail(
                        name, 
                        cardNumber, 
                        cvv, 
                        validDate,
                       ),
                      ),
                    ),
                   );
                }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$_message'),
                    ),
                  );
                },
              
              child: Text(
                'PAYMENT',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(400, 50),
                primary: Colors.lightGreen,
                 onPrimary: Colors.white,
              ),
            
            ),
          ],
        ),
      ),
    );
  }
}
class ConfirmPayment extends StatelessWidget{
  final PaymentDetail detail;

  const ConfirmPayment({super.key,required this.detail});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:Text('Confirm payment'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(detail.name),
          Text(detail.cardNumber),
          Text(detail.cvv),
          Text(detail.validDate),
        ],
       ),
    );
  }
}
class PaymentDetail {
  final String name;
  final String cardNumber;
  final String cvv;
  final String validDate;

  const PaymentDetail(this.name, this.cardNumber,this.cvv,this.validDate);
}