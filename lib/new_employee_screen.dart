import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'employee_service.dart';

class NewEmployeeScreen extends StatelessWidget {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final position = TextEditingController();
  final salary = TextEditingController();

  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Employee"),
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
                  onPressed: addEmployee,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  addEmployee() {
    _employeeService.addEmployee2Firebase(fname.text, {
      "fname": fname.text,
      "lname": lname.text,
      "position": position.text,
      "salary": salary.text
    });
  }
}
