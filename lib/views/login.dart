import 'dart:convert';
import 'package:demoapp/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/wcoe.jpeg", fit: BoxFit.fill, color: Colors.black.withOpacity(0.5), colorBlendMode: BlendMode.darken,),
            Center(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Form(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Walchand College of Engineering,  Sangli",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              hintText: "Enter Username",
                              labelText: "Username",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.lightBlue))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2, 
                                  color: Colors.lightBlue
                                )
                              )),
                              
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container( 
                            child: ElevatedButton(onPressed: ()=>Auth.login(usernameController.text, passwordController.text, this.context), child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("SignIn"),
                            ))
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              )),
            )
          ],
        ));
  }
}
