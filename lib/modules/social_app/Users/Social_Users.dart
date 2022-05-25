import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).users.length > 0,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFriends(
                      context, SocialCubit.get(context).users[index], index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: SocialCubit.get(context).users.length),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}

bool isClick = false;
Widget buildFriends(context, SocialUserModel userModel, index) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${userModel.image}'),
                radius: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '${userModel.name}',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              click(),
              // IconButton(
              //     onPressed: () {
              //       setState(() {
              //         isClick = !isClick;
              //       });
              //
              //     },
              //     icon: isClick==true
              //         ? Icon(Icons.person_add_alt_1)
              //         : Icon(Icons.person_remove)),
            ],
          ),
        ),
      ],
    ),
  );
}

class click extends StatefulWidget {
  @override
  _clickState createState() => _clickState();
}

class _clickState extends State<click> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isClick = !isClick;
          });
        },
        icon:
            isClick ? Icon(Icons.person_add_alt_1) : Icon(Icons.person_remove));
  }
}
