import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee_service.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen(
      {super.key,
      required this.fname,
      required this.lname,
      required this.position,
      required this.salary,
      required this.documentid});
  final String documentid;
  final String fname;
  final String lname;
  final String position;
  final String salary;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final position = TextEditingController();
  final salary = TextEditingController();

  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    fname.text = widget.fname;
    lname.text = widget.lname;
    position.text = widget.position;
    salary.text = widget.salary;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลพนักงาน"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "ชื่อ",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: fname,
                decoration: InputDecoration(label: Text("First name")),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "นามสกุล",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: lname,
                decoration: InputDecoration(label: Text("Last name")),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "ตำแหน่ง",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: position,
                decoration: InputDecoration(label: Text("Postion")),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "เงินเดือน",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: salary,
                decoration: InputDecoration(label: Text("Salary")),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "บันทึกข้อมูล",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _editEmployee(context, widget.documentid);
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "ลบข้อมูล",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _deleteEmployee(context, widget.documentid);
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _editEmployee(BuildContext context, documentid) {
    _employeeService.editEmployee(context, documentid, {
      "fname": fname.text,
      "lname": lname.text,
      "position": position.text,
      "salary": salary.text
    }).then((value) => Navigator.pop(context));
  }

  void _deleteEmployee(BuildContext context, documentid) {
    _employeeService
        .deleteEmployee(
            context,
            {
              "fname": fname.text,
              "lname": lname.text,
              "position": position.text,
              "salary": salary.text
            },
            documentid)
        .then((value) => Navigator.pop(context));
    fname.text = "";
    lname.text = "";
    position.text = "";
    salary.text = "";
  }
}
