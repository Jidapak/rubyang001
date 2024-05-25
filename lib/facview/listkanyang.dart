import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListKanyang extends StatefulWidget {
  @override
  _ListKanYangState createState() => _ListKanYangState();
}

class _ListKanYangState extends State<ListKanyang> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roadController = TextEditingController();
  final _subdistrictController = TextEditingController();
  final _telNumController = TextEditingController();
  final _campianController = TextEditingController();
  final _newsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "การยางแต่ละอำเภอสุราษฎร์",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("kanyang").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: snapshot.data!.docs.map<Widget>((kanyangDocument) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow(
                                  "ชื่อร้าน", kanyangDocument["Name"]),
                              _buildInfoRow("ถนน", kanyangDocument["Road"]),
                              _buildInfoRow("ตำบล",
                                  kanyangDocument["Subdistrict"]),
                              _buildInfoRow("เบอร์ติดต่อ",
                                  kanyangDocument["TelNum"]),
                              _buildInfoRow("แคมเปญ",
                                  kanyangDocument["campian"]),
                              _buildInfoRow("ข่าวสาร",
                                  kanyangDocument["News"]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOrUpdateDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showAddOrUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add or Update Document'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(_nameController, 'Name'),
                  _buildTextField(_roadController, 'Road'),
                  _buildTextField(_subdistrictController, 'Subdistrict'),
                  _buildTextField(_telNumController, 'TelNum'),
                  _buildTextField(_campianController, 'Campian'),
                  _buildTextField(_newsController, 'News'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateOrCreateDocument({
                    "Name": _nameController.text,
                    "Road": _roadController.text,
                    "Subdistrict": _subdistrictController.text,
                    "TelNum": _telNumController.text,
                    "campian": _campianController.text,
                    "News": _newsController.text,
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _updateOrCreateDocument(Map<String, dynamic> newDocument) async {
    final query = await FirebaseFirestore.instance
        .collection("kanyang")
        .where("Name", isEqualTo: newDocument["Name"])
        .get();

    if (query.docs.isNotEmpty) {
      // Update the existing document
      final docId = query.docs.first.id;
      await FirebaseFirestore.instance
          .collection("kanyang")
          .doc(docId)
          .update(newDocument);
    } else {
      // Create a new document
      await FirebaseFirestore.instance.collection("kanyang").add(newDocument);
    }
  }
}
