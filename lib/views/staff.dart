import 'package:demoapp/utils/constants.dart';
import 'package:demoapp/views/profile.dart';
import 'package:demoapp/views/tattendance.dart';
import 'package:flutter/material.dart';
import '../utils/auth.dart';
import './take_attendance.dart';
import '../utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Staff extends StatefulWidget {
  const Staff({super.key});

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  var sel = 0;
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
      appBar: AppBar(
        title: Text("Staff View"),
      ),
      body: sel == 0
          ? Profile()
          : sel == 1
              ? TakeAttendance()
              : StaffAttendance(),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
              accountName:
                  Text("${account['firstName']}  ${account['lastName']}"),
              accountEmail: Text("${account['email']}")),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Details"),
            onTap: () {
              setState(() {
                sel = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.install_mobile_outlined),
            title: Text("Take Attendance"),
            onTap: () {
              setState(() {
                sel = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_outlined),
            title: Text("Show Attendance"),
            onTap: () {
              setState(() {
                sel = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => Auth.logout(context)),
        ]),
      ),
    );
  }
}
