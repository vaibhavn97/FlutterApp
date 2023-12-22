import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'dart:convert';
import '../utils/urls.dart';
import 'package:http/http.dart' as http;

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({super.key});

  @override
  State<TakeAttendance> createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  String? classRoomValue = null;
  String? subjectValue = null;
  List<String>? classRoomList = null;
  List<String>? subjectList = null;
  void updateList() async {
    print(Constants.prefs.getInt("userId"));
    var uri = Uri.parse(Urls.BASE_URL + Urls.GET_AVAILABLE_CLASSES);
    var response = await http.post(uri);
    var data = jsonDecode(response.body);
    List<String> tmp = [];
    for (var ele in data['data']) {
      tmp.add(ele);
    }
    if (classRoomList == null) {
      setState(() {
        classRoomList = tmp;
      });
    }
    tmp = [];
    uri = Uri.parse(Urls.BASE_URL + Urls.GET_STAFF_COURSES);
    var userId = Constants.prefs.getInt("userId").toString();
    response = await http.post(uri, body: {'userId': userId});
    data = jsonDecode(response.body);
    for (var ele in data['data']) {
      tmp.add(ele);
    }
    if (subjectList == null) {
      setState(() {
        subjectList = tmp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Text("Take Attendance"),
        SizedBox(height: 20),
        DropdownButton(
          // Initial Value
          value: classRoomValue,
          hint: Text("Select Class Room"),
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: classRoomList?.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              classRoomValue = newValue!;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButton(
          // Initial Value
          value: subjectValue,
          hint: Text("Select Your Course"),
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
              subjectValue = newValue!;
            });
          },
        ),
        SizedBox(height: 20),

        ElevatedButton(
            onPressed: () async{
              var uri = Uri.parse(Urls.BASE_URL + Urls.SET_AVAILABLE_CLASSES);
              var response = await http.post(uri, body:{
                'classroomNumber': classRoomValue,
                'courseCode': subjectValue
              });
              var data = jsonDecode(response.body);
    
            },
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Start",
              ),
              
            )),

        ElevatedButton(
            onPressed: () async{
              var uri = Uri.parse(Urls.BASE_URL + Urls.CLEAR_AVAILABLE_CLASSES);
              var response = await http.post(uri, body:{
                'classroomNumber': classRoomValue,
                'courseCode': subjectValue
              });
              var data = jsonDecode(response.body);
    
            },
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Stop",
              ),
            ))
      ],
    )));
  }
}