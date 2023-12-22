import 'package:demoapp/utils/auth.dart';
import 'package:flutter/material.dart';
import './profile.dart';
import './sattendance.dart';
import '../utils/urls.dart';
import 'dart:convert';
import "../utils/constants.dart";
import 'package:http/http.dart' as http;

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {

  int sel = 0;
  var account = {
    "isSet": false,
    "firstName": "Vaibhav",
    "lastName": "Nayak",
    "email": "vaibhav.nayak@walchandsangli.ac.in",
  };
  void getData() async {
    var uri = Uri.parse(Urls.BASE_URL + Urls.GET_PROFILE_DATA);
    var userId = Constants.prefs.getInt("userId").toString();
    var response = await http.post(uri, body: {'userId': userId});
    var data = jsonDecode(response.body);
    if (account['isSet'] == false) {
      setState(() {
        account['firstName'] = data['first_name'];
        account['lastName'] = data['last_name'];
        account['email'] = data['email'];
      });
      account['isSet'] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(title: Text("Student View")),
      body: sel==0?Profile():StudentAttendance(),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
              accountName: Text("${account['firstName']} ${account['lastName']}"), accountEmail: Text("${account['email']}")),
              ListTile(
                onTap: () {
                  setState(() {
                    sel = 0;
                  });
                  Navigator.pop(context);
                },
                title: Text("Account Details"),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    sel = 1;
                  });
                  Navigator.pop(context);
                },
                title: Text("Show Attendance"),
                leading: Icon(Icons.calendar_month_outlined),
              ),
              ListTile(
                onTap: () => Auth.logout(context),
                title: Text("Logout"),
                leading: Icon(Icons.logout),
              ),
        ]),
      ),
    );
  }
}
