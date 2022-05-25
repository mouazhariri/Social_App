import 'package:flutter/material.dart';
import 'package:flutter_appp/models/users/users.dart';
import 'package:flutter_appp/modules/social_app/Chatts/Chatt_Screen.dart';
import 'package:flutter_appp/shared/components/components.dart';

// ignore: must_be_immutable
class UsersScreen extends StatelessWidget {
  // ignore: non_constant_identifier_names
  List<UserModel> users = [
    UserModel(id: 1, name: 'moauz', phone: '+9659446325'),
    UserModel(id: 2, name: 'moadsas', phone: '+9659446325'),
    UserModel(id: 3, name: 'mdwwwqa', phone: '+9659446325'),
    UserModel(id: 4, name: 'sadsa', phone: '+9659446325'),
    UserModel(id: 5, name: 'daswd', phone: '+9659446325'),
    UserModel(id: 6, name: 'mdasiuhg', phone: '+9659446325'),
    UserModel(id: 1, name: 'moauz', phone: '+9659446325'),
    UserModel(id: 2, name: 'moadsas', phone: '+9659446325'),
    UserModel(id: 3, name: 'mdwwwqa', phone: '+9659446325'),
    UserModel(id: 4, name: 'sadsa', phone: '+9659446325'),
    UserModel(id: 5, name: 'daswd', phone: '+9659446325'),
    UserModel(id: 6, name: 'mdasiuhg', phone: '+9659446325'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'USERS',
          style: TextStyle(
            color: Colors.lime,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) =>
              builduseritem(users[index], context), //بقعد بستخرج item,item
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                color: Colors.grey,
                height: 2.0,
              ),
          itemCount: users.length), //بحطا بمحلها
    );
  }

//بستقبل ال item in widget
  Widget builduseritem(UserModel user, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.red,
              child: Text('${user.id}'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
}
