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
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              isLogin
                  ? Container()
                  : TextFormField(
                      validator: (user) {
                        if (user == null || user.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      key: ValueKey('user'),
                      decoration: InputDecoration(hintText: "Enter Username"),
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    ),
              TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter some text';
                  }
                },
                decoration: InputDecoration(hintText: "Enter email"),
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter some text';
                  }
                },
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
