import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentAttendance extends StatefulWidget {
  const StudentAttendance({super.key});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  String? dropdownValue = null;
  List<String>? subjectList = null;
  void updateList() async {
    print(Constants.prefs.getInt("userId"));
    var uri = Uri.parse(Urls.BASE_URL + Urls.GET_STUDENT_COURSES);
    var userId = Constants.prefs.getInt("userId").toString();
    var response = await http.post(uri, body: {'userId': userId});
    var data = jsonDecode(response.body);
    List<String> tmp = [];
    for (var ele in data['data']) {
      tmp.add(ele);
    }
    if (subjectList == null) {
      setState(() {
        subjectList = tmp;
      });
    }
    print(subjectList);
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Text("Show Attendance"),
        SizedBox(height: 20),
        DropdownButton(
          // Initial Value
          value: dropdownValue,
          hint: Text("Select Course"),
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: subjectList?.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              print("I will show Attendance for ${dropdownValue}");
            },
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Submit",
              ),
            ))
      ],
    )));
  }
}



