import 'package:flutter/material.dart';

class AddMedicalRecord extends StatefulWidget {
  @override
  _AddMedicalRecordState createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  String name;
  String address;
  String email;
  String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding new medical record'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              buildNameFormField(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onEditingComplete: () => print(name),
      
    );
  }
}
