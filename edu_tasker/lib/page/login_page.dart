import 'dart:ffi';

import 'package:edu_tasker_app/constants/materialDesign.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 55, 29, 100),
          Color.fromARGB(255, 20, 47, 114)
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 24, 28, 75),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email",
                  style: subtitle,
                ),
                // TextField Receive Email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Colors.grey), // ตั้งค่าสีของ hint
                    ),
                  ),
                ),
                Text(
                  "Password",
                  style: subtitle,
                ),
                //TextField Receive Password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Colors.grey), // ตั้งค่าสีของ hint
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 48,
                      width: 128,
                      child: ElevatedButton(
                        child: Text('SIGN UP', style: TextStyle(
                          color: Colors.white, fontSize: 14,
                        ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          //TODO sign up
                          context.push('/signup');
                        },
                      ),
                    ),
                    SizedBox(width: 16,),
                    SizedBox(
                      height: 48,
                      width: 128 ,
                      child: ElevatedButton(
                        child: Text('LOGIN', style: TextStyle(
                          color: Colors.white, fontSize: 14,
                        ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) => 
                          context.go('/home')).onError((error, stackTrace) => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Faild'),
                                  content: const Text("Login failed"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ));
                          //TODO login
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
