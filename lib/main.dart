import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Auth/login_screen.dart';
import 'Auth/services/auth_service.dart';
import 'edit_employee_screen.dart';
import 'firebase_options.dart';
import 'new_employee_screen.dart';


Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

AuthService _service = AuthService();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'รายชื่อพนักงาน'),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(255, 121, 109, 152),
      drawerScrimColor: Color.fromARGB(255, 244, 240, 240),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE6E6E6),
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        color: Color(0xffCCCCCC),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$displayEmail",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
              // child: Text("User : $displayEmail")),
            ),
            ListTile(
              tileColor: Color.fromARGB(255, 74, 129, 152),
              textColor: Colors.white,
              title: Text(
                "เพิ่มพนักงาน",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _createNewEmployee();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              tileColor: Color.fromARGB(255, 168, 41, 10),
              textColor: Colors.white,
              title: Text("Log Out"),
              onTap: () {
                _service.logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("employee").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("no data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _editEmployeeScreen(
                    documentid: dataDocuments[index].id,
                    fname: dataDocuments[index]["fname"],
                    lname: dataDocuments[index]["lname"],
                    position: dataDocuments[index]["position"],
                    salary: dataDocuments[index]["salary"]),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Color(0xffCCCCCC),
                    ),
                  ),
                  textColor: Colors.white,
                  title: Text(dataDocuments[index]["fname"].toString()),
                  subtitle: Text(dataDocuments[index]["position"].toString()),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewEmployee,
        tooltip: 'Create New Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewEmployee() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewEmployeeScreen()));
  }

  _editEmployeeScreen(
      {required String documentid,
      required String fname,
      required String lname,
      required String position,
      required String salary}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditEmployeeScreen(
                documentid: documentid,
                fname: fname,
                lname: lname,
                position: position,
                salary: salary)));
  }
}
