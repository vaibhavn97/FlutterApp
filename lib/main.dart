import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/student.dart';
import './views/staff.dart';
import './views/login.dart';
import './utils/constants.dart';
import './utils/auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  print("I am starting");
  Auth.verifyAtLogin();
  print("App Verified");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool? isLogin = Constants.prefs.getBool("isLogin");
    bool? isStaff = Constants.prefs.getBool("isStaff");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLogin == false)
          ? LoginPage()
          : (isStaff == true ? Staff() : Student()),
      routes: {
        '/login': (context) => LoginPage(),
        '/staff': (context) => Staff(),
        '/student': (context) => Student()
      },
    );
  }
}
