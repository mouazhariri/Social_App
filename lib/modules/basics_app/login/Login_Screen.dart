//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../messenger/Messenger_Screen.dart';
import 'package:flutter_appp/shared/components/components.dart';
//import 'package:flutter_application/shared/components/components.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwoardcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispasswoard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {},
          ),
          title: const Text('WELCOM'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  print('new page');
                },
                icon: Icon(Icons.notifications))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    defaulttextformfield(
                      controller: emailcontroller,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'email must be not empty';
                        }
                        return null;
                      },
                      label: 'Email Adress',
                      prefix: Icons.email_rounded,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaulttextformfield(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password must be not empty';
                          }
                          return null;
                        },
                        controller: passwoardcontroller,
                        type: TextInputType.visiblePassword,
                        label: 'password',
                        prefix: Icons.lock,
                        ispasswoard: ispasswoard,
                        suffix: ispasswoard
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixpressed: () {
                          setState(() {
                            ispasswoard = !ispasswoard;
                          });
                        }),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            print(emailcontroller);
                            print(passwoardcontroller);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessengerScreen()));
                          }
                        },
                        child: Text(
                          'LoGiN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultbutton(
                      text: 'Regestir',
                      function: () {
                        print(emailcontroller);
                        print(passwoardcontroller);
                      },
                      background: Colors.red,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Register now',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
// ),
//crossAxisAlignment:CrossAxisAlignment.start,
// Container(
//   width: double.infinity,
//   color: Colors.blue,
//   child: MaterialButton(
//     onPressed: () {
//       print(emailcontroller.text);
//       print(passwoardcontroller.text);
//     },
//     child: Text(
//       'subment',
//     ),
//   ),
// ), // Container(
//   width: double.infinity,
//   color: Colors.blue,
//   child: MaterialButton(
//     onPressed: () {
//       print(emailcontroller.text);
//       print(passwoardcontroller.text);
//     },
//     child: Text(
//       'subment',
//     ),
//   ),
// ),
