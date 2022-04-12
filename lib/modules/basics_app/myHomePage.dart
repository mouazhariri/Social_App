// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:core';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Future<List<Users>> _getUsers() async {
//     var data = await http.get(
//         "https://www.learningcontainer.com/sample-json-file/#JSON_file_example_1");
//     var jsonData = json.decode(data.body);
//
//     List<Users> users = [];
//     for (var u in jsonData) {
//       Users user = Users( emailAddress: '', firstName: '', phoneNumber: '', userId:1, lastName:);
//       users.add(user);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('rrrr'),
//       ),
//       body: Container(
//         child: FutureBuilder(builder: (BuildContext context,As),
//         future: _getUsers(),),
//       ),
//     );
//   }
// }
//
// class Users {
//   final int userId;
//   final String firstName;
//   final bool lastName;
//   final String phoneNumber;
//   final String emailAddress;
//   Users({
//     required this.userId,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneNumber,
//     required this.emailAddress,
//   });
// }
