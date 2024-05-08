

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class BudgetController {
  final BudgetService _budgetService = BudgetService();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Budget>> fetchBudgets() async {
    print('fetchBudgets is called');
    onSyncController.add(true);
    try {
      List<Budget> budgets = await _budgetService.fetchBudgets();
      print(budgets);
      onSyncController.add(false);
      return budgets;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<Budget?> addBudget(Map<String, dynamic> newBudgetData) async {
    print('addBudget is called');
    onSyncController.add(true);
    try {
      Budget addedBudget = await _budgetService.addBudget(newBudgetData);
      print(addedBudget);
      onSyncController.add(false);
      return addedBudget;
    } catch (e) {
      print("Error adding budget: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<Budget?> updateBudget(
      String budgetId, Map<String, dynamic> updatedBudgetData) async {
    print('updateBudget is called');
    onSyncController.add(true);
    try {
      Budget updatedBudget =
          await _budgetService.updateBudget(budgetId, updatedBudgetData);
      print(updatedBudget);
      onSyncController.add(false);
      return updatedBudget;
    } catch (e) {
      print("Error updating budget: $e");
      onSyncController.add(false);
      return null;
    }
  }

  Future<List<Budget>> fetchBudgetsByStatus(String status) async {
    print('fetchBudgetsByStatus is called');
    onSyncController.add(true);
    try {
      List<Budget> budgets = await _budgetService.fetchBudgetsByStatus(status);
      print(budgets);
      onSyncController.add(false);
      return budgets;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<List<Budget>> fetchPendingData() async {
    onSyncController.add(true);
    try {
      List<Budget> budgets = await _budgetService.fetchPendingBudgets();
      onSyncController.add(false);
      return budgets;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<List<Budget>> fetchApprovedData() async {
    onSyncController.add(true);
    try {
      List<Budget> budgets = await _budgetService.fetchApprovedBudgets();
      onSyncController.add(false);
      return budgets;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<List<Budget>> fetchRejectedData() async {
    onSyncController.add(true);
    try {
      List<Budget> budgets = await _budgetService.fetchRejectedBudgets();
      onSyncController.add(false);
      return budgets;
    } catch (e) {
      onSyncController.add(false);
      throw e;
    }
  }

  Future<void> addReport(Map<String, dynamic> reportData) async {
    try {
      await _budgetService.addReport(reportData);
    } catch (e) {
      print("Error adding report: $e");
      throw e;
    }
  }
}

class Budget {
  String id;
  String budgetNo;
  String eventNo;
  num boothcost;
  num countdate;
  num countstaff;
  num tripcost;
  num sumdaily;
  num sumfood;
  num amount;
  String status;
  String workstatus;
  String staffNo;
  String staffname;
  String createdBy; // เพิ่มข้อมูลผู้สร้าง
  DateTime createdAt; // เพิ่มข้อมูลวันที่สร้าง

  String startdate;
  String enddate;
  Timestamp? timestamp;

  //num price;

  Budget(
    this.id,
    this.budgetNo,
    this.eventNo,
    this.boothcost,
    this.countdate,
    this.countstaff,
    this.tripcost,
    this.sumdaily,
    this.sumfood,
    this.amount,
    this.status,
    this.workstatus,
    this.staffNo,
    this.staffname,
    this.createdBy, // เพิ่มข้อมูลผู้สร้าง
    this.createdAt, // เพิ่มข้อมูลวันที่สร้าง
    this.startdate,
    this.enddate,
    this.timestamp,
  );

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      json['id'] as String,
      json['budgetNo'] as String,
      json['eventNo'] as String,
      json['boothcost'] as num,
      json['countdate'] as num,
      json['countstaff'] as num,
      json['tripcost'] as num,
      json['sumdaily'] as num,
      json['sumfood'] as num,
      json['amount'] as num,
      json['status'] as String,
      json['workstatus'] as String,
      json['staffNo'] as String,
      json['staffname'] as String,
      json['createdBy'] as String, // เพิ่มข้อมูลผู้สร้าง
      (json['createdAt'] as Timestamp).toDate(), // เพิ่มข้อมูลวันที่สร้าง
      json['startdate'] as String,
      json['enddate'] as String,
      json['timestamp'] as Timestamp,
    );
  }

  factory Budget.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return Budget(
      snapshot.id,
      json['budgetNo'] as String,
      json['eventNo'] as String,
      json['boothcost'] as num,
      json['countdate'] as num,
      json['countstaff'] as num,
      json['tripcost'] as num,
      json['sumdaily'] as num,
      json['sumfood'] as num,
      json['amount'] as num,
      json['status'] as String,
      json['workstatus'] as String,
      json['staffNo'] as String,
      json['staffname'] as String,
      json['createdBy'] as String, // เพิ่มข้อมูลผู้สร้าง
      (json['createdAt'] as Timestamp).toDate(), // เพิ่มข้อมูลวันที่สร้าง
      json['startdate'] as String,
      json['enddate'] as String,
      json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'budgetNo': budgetNo,
      'eventNo': eventNo,
      'boothcost': boothcost,
      'countdate': countdate,
      'countstaff': countstaff,
      'tripcost': tripcost,
      'sumdaily': sumdaily,
      'sumfood': sumfood,
      'amount': amount,
      'status': status,
      'workstatus': workstatus,
      'staffNo': staffNo,
      'staffname': staffname,
      'createdBy': createdBy, // เพิ่มข้อมูลผู้สร้าง
      'createdAt': createdAt, // เพิ่มข้อมูลวันที่สร้าง
      'startdate': startdate,
      'enddate': enddate,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  String toString() {
    return 'YourClassName{id: $id, budgetNo: $budgetNo, eventNo: $eventNo,boothcost: $boothcost,countdate: $countdate,countstaff: $countstaff,tripcost: $tripcost,sumdaily: $sumdaily,sumfood: $sumfood,amount: $amount,status: $status,workstatus: $workstatus,staffNo: $staffNo,staffname: $staffname,createdBy: $createdBy,createdAt: $createdAt,startdate: $startdate,enddate:$enddate,timestamp:$timestamp}';
  }
}

class AllBudgets {
  final List<Budget> budgets;

  AllBudgets(this.budgets);

  factory AllBudgets.fromJson(List<dynamic> json) {
    List<Budget> budgets = json.map((item) => Budget.fromJson(item)).toList();
    return AllBudgets(budgets);
  }

  factory AllBudgets.fromSnapshot(QuerySnapshot qs) {
    List<Budget> budgets = qs.docs.map((DocumentSnapshot ds) {
      Map<String, dynamic> dataWithId = ds.data() as Map<String, dynamic>;
      dataWithId['id'] = ds.id;
      return Budget.fromJson(dataWithId);
    }).toList();
    return AllBudgets(budgets);
  }

  Map<String, dynamic> toJson() {
    return {
      'budgets': budgets.map((budget) => budget.toJson()).toList(),
    };
  }
}

class BudgetsProvider extends ChangeNotifier {
  List<Budget>? _allBudgets = [];

  List<Budget>? get allBudgets => _allBudgets;

  void setBudgets(List<Budget>? budgets) {
    _allBudgets = budgets;
    notifyListeners();
  }

  void addBudget(Budget budget) {
    print("addBudget @ provider is called");
    _allBudgets!.add(budget);
    notifyListeners();
  }

  void updateBudget(Budget updatedBudget) {
    print("updateBudget @ provider is called");
    int index =
        _allBudgets!.indexWhere((budget) => budget.id == updatedBudget.id);
    if (index != -1) {
      _allBudgets![index] = updatedBudget;
      notifyListeners();
    }
  }
}
   class BudgetService {
  Future<List<Budget>> fetchBudgets() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('budgets').get();

      print("Budgets in firebase count:${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Budget.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching budgets: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<String> generateBudgetNumber() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // หา budgetNo ล่าสุด
        String lastBudgetNo = snapshot.docs.first.get('budgetNo');
        // ตัดเลขออกมาและบวกเพิ่มทีละ 1
        int lastNumber = int.parse(lastBudgetNo.substring(2));
        int newNumber = lastNumber + 1;
        // สร้าง budgetNo ใหม่
        String newBudgetNo = 'BG${newNumber.toString().padLeft(4, '0')}';
        return newBudgetNo;
      } else {
        // ถ้ายังไม่มีเลข budgetNo ใน Firestore
        return 'BG0001';
      }
    } catch (e) {
      print("Error generating budget number: $e");
      throw e;
    }
  }

  Future<Budget> addBudget(Map<String, dynamic> newBudgetData) async {
    try {
      // เพิ่มข้อมูลผู้สร้างและวันที่สร้างลงใน newBudgetData
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user signed in.');
      }
      newBudgetData['createdBy'] = currentUser.uid;
      newBudgetData['createdAt'] = DateTime.now();

// Generate budgetNo
      String budgetNo = await generateBudgetNumber();

      // เพิ่ม budgetNo ใน newBudgetData
      newBudgetData['budgetNo'] = budgetNo;

      // เพิ่ม field 'timestamp' ใน newBudgetData
      newBudgetData['timestamp'] = FieldValue.serverTimestamp();

      DocumentReference ref = await FirebaseFirestore.instance
          .collection('budgets')
          .add(newBudgetData);

      // Fetch the newly added document
      DocumentSnapshot newDoc = await ref.get();
      return Budget.fromSnapshot(newDoc);
    } catch (e) {
      print("Error adding budget: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<Budget> updateBudget(
      String budgetId, Map<String, dynamic> updatedBudgetData) async {
    try {
      // เพิ่ม field 'timestamp' ใน updatedBudgetData
      updatedBudgetData['timestamp'] = FieldValue.serverTimestamp();
      DocumentReference budgetRef =
          FirebaseFirestore.instance.collection('budgets').doc(budgetId);

      // Update the document
      await budgetRef.update(updatedBudgetData);

      // Fetch the updated document
      DocumentSnapshot updatedDoc = await budgetRef.get();
      return Budget.fromSnapshot(updatedDoc);
    } catch (e) {
      print("Error updating budget: $e");
      throw e;
    }
  }

  Future<void> deleteBudget(String budgetId) async {
    try {
      await FirebaseFirestore.instance
          .collection('budgets')
          .doc(budgetId)
          .delete();
    } catch (e) {
      print("Error deleting budget: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<List<Budget>> fetchBudgetsByStatus(String status) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('status', isEqualTo: status) // กรองข้อมูลตาม status
          .get();

      print("Budgets in firebase count:${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Budget.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching budgets: $e");
      throw e; // rethrow the error for the controller to handle
    }
  }

  Future<List<Budget>> fetchPendingBudgets() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('status', isEqualTo: 'Pending')
          .get();

      print("Pending Budgets in firebase count: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Budget.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching pending budgets: $e");
      throw e;
    }
  }

  Future<List<Budget>> fetchApprovedBudgets() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('status', isEqualTo: 'Approved')
          .get();

      print("Approved Budgets in firebase count: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Budget.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching approved budgets: $e");
      throw e;
    }
  }

  Future<List<Budget>> fetchRejectedBudgets() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('status', isEqualTo: 'Rejected')
          .get();

      print("Rejected Budgets in firebase count: ${snapshot.docs.length}");

      return snapshot.docs.map((doc) => Budget.fromSnapshot(doc)).toList();
    } catch (e) {
      print("Error fetching Rejected budgets: $e");
      throw e;
    }
  }

  Future<void> addReport(Map<String, dynamic> reportData) async {
    try {
      // เพิ่มข้อมูลรายงานลงใน collection "reports"
      await FirebaseFirestore.instance.collection('reports').add(reportData);
    } catch (e) {
      print("Error adding report: $e");
      throw e;
    }
  }
}
  // static of(BuildContext context) {}

// import 'package:flutter/material.dart';

// class NotiPay extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'แจ้งเตือน',
//           style: TextStyle(
//             fontSize: 20.0,
//             letterSpacing: 2.0,
//             color: Colors.brown,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       backgroundColor: Colors.brown,
//       body: ListView(
//         padding: EdgeInsets.all(20),
//         children: [
//           Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(vertical: 10),
//             child: ListTile(
//               title: Text(
//                 'เลขคำสั่งซื้อ 1001 สมาชิก 10001',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                 ),
//               ),
//               subtitle: Text('โอนเงินยอด 2500 บาทเรียบร้อยแล้ว'),
//             ),
//           ),
//           SizedBox(height: 20),
//           Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(vertical: 10),
//             child: ListTile(
//               title: Text(
//                 'เลขคำสั่งซื้อ 1002 สมาชิก 10002',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                 ),
//               ),
//               subtitle: Text('โอนเงินยอด 5000 บาทเรียบร้อยแล้ว'),
//             ),
//           ),
//           Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(vertical: 10),
//             child: ListTile(
//               title: Text(
//                 'เลขคำสั่งซื้อ 1002 สมาชิก 10002',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown,
//                 ),
//               ),
//               subtitle: Text('ยางพาราของท่านใกล้ครบกำหนดปลูกยางใหม่แทนยางเก่าในอีก11เดือน'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
