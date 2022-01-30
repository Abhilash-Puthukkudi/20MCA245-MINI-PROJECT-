import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:productivity_app/services/authfunctions.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String username = '';
  String password = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLogin
                  ? Container()
                  : TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(hintText: "Enter Username"),
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    ),
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(hintText: "Enter email"),
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        isLogin
                            ? signin(email, password, context)
                            : signup(email, password, username, context);
                      }
                    },
                    child: Text(isLogin ? 'login' : 'signup')),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin
                      ? "Dont you have an account? Signup"
                      : "Already have an account? Login."))
            ],
          ),
        ),
      ),
    );
  }
}
