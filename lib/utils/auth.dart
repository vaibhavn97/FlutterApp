import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import './constants.dart';
import './urls.dart';
import 'package:flutter/material.dart';

class Auth {
  static void login(username, password, context) async {
    print("I Was Clicked");
    var uri = Uri.parse(Urls.BASE_URL + Urls.TOKEN_CREATE);
    print(username + " " + password);
    var response = await http
        .post(uri, body: {'username': username, 'password': password});
    print(response);
    var data = jsonDecode(response.body);
    if (response.statusCode == 401) {
      Fluttertoast.showToast(
        msg: "Invalid Credentials",
      );
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: "Enter Login Details",
      );
    } else {
      Constants.prefs.setString('token', data['access']);
      var uri = Uri.parse(Urls.BASE_URL + Urls.TOKEN_VERIFY);
      var response = await http.post(uri, body: {'token': data['access']});
      var staffData = jsonDecode(response.body);
      Constants.prefs.setBool('isLogin', true);
      bool is_staff = staffData['is_staff'];
      print("You are a staff ------------------------");
      print(is_staff);
      Constants.prefs.setBool('isStaff', is_staff);
      Constants.prefs.setInt("userId", staffData['user_id']);
      Navigator.pushReplacementNamed(
          context, (is_staff) ? "/staff" : "/student");
    }
  }

  static void verifyAtLogin() async {
    if (Constants.prefs.getBool('isLogin') == true &&
        Constants.prefs.getString("token") != null) {
      var uri = Uri.parse(Urls.BASE_URL + Urls.TOKEN_VERIFY);
      print(Constants.prefs.getString('token') == null);
      var response = await http
          .post(uri, body: {'token': Constants.prefs.getString('token')});
      var data = jsonDecode(response.body);
      print(data);
      Constants.prefs.setBool('isLogin', !data['isExp']);
    } else {
      Constants.prefs.setBool("isLogin", false);
    }
  }

  static void logout(context) {
    Constants.prefs.remove('isStaff');
    Constants.prefs.setBool('isLogin', false);
    Constants.prefs.remove('token');
    Constants.prefs.remove('userId');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
