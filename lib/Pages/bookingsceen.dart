// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:im_stepper/stepper.dart';

// class BookingScreen extends ConsumerWidget {
//   final currentStep = StateProvider((ref) => 1);
//   final selectedCity = StateProvider((ref) => '');
//   final selectStore = StateProvider((ref) => '');

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//      var step = ref.watch(currentStep);
//     var cityWatch = ref.watch(selectedCity);
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white10,
//         body: Column(
//           children: [
//             NumberStepper(
//               activeStep: step - 1,
//               direction: Axis.horizontal,
//               enableNextPreviousButtons: false,
//               enableStepTapping: false,
//               numbers: [1, 2, 3, 4, 5],
//               stepColor: Colors.black,
//               activeStepColor: Colors.black87,
//               numberStyle: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
