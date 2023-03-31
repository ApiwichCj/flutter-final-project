import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class EmployeeService {
  Future<void> addEmployee2Firebase(String docname, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("employee")
        .doc(docname)
        .set(data)
        .then((value) {
      print("Employee created");
    }).catchError((error) {
      print("Can't create :" + error.toString());
    });
  }

  Future<void> editEmployee(
      BuildContext context, String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("employee")
        .doc(documentid)
        .update(data)
        .then((value) {
      print("Employee update");
    }).catchError((error) {
      print("Can't update :" + error.toString());
    });
  }

  Future<void> deleteEmployee(
      BuildContext context, Map<String, String> data, String documentid) {
    print(documentid);
    return FirebaseFirestore.instance
        .collection("employee")
        .doc(documentid)
        .delete()
        .then((value) {
      print("deleted");
    }).catchError((error) {
      print("Can't delete :" + error.toString());
    });
  }
}
