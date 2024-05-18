import 'package:flutter/material.dart';

class TimelinePayment extends StatefulWidget {
  @override
  _TimelinePaymentState createState() => _TimelinePaymentState();
}

class _TimelinePaymentState extends State<TimelinePayment> {
  int currentStep = 0;

  void continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  void cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  void onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }
 Widget controlsBuilder(BuildContext context, ControlsDetails details) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: details.onStepContinue, 
        child: const Text('Next',
        style: TextStyle(
          fontSize: 16
        ),
        ),
      ),
      OutlinedButton(
        onPressed: details.onStepCancel,
        child: const Text('Back',
        style: TextStyle(
          fontSize: 16
        )
        ),
      ),
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สถานะการจ่ายเงิน',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 2.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stepper(
        margin: const EdgeInsets.all(60),
        physics:  const ClampingScrollPhysics(),
        elevation: 0,
       type: StepperType.vertical, 
        currentStep: currentStep,
        onStepContinue: continueStep,
        onStepCancel: cancelStep,
        onStepTapped: onStepTapped,
        controlsBuilder: controlsBuilder,
        steps: [
          Step(
            title: const Text('Step1'),
            content: Row(
              children: [
                const Text('คำนวณยอดเงินที่ต้องจ่าย'),
              ],
            ),
            isActive: currentStep>=0,
            state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title:const Text('Step2'),
            content: const Text('จ่ายเงินให้ลูกค้า'),
               isActive: currentStep>=1,
               state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title:const Text('Step3'),
            content:const Text('ปิดการซื้อขาย'),
               isActive: currentStep >= 2,
               state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
        ], 
      ),
    );
  }
}
