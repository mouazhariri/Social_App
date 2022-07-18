import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialUserModel? userModel = SocialCubit.get(context).userModel;

          return Padding(
            padding: EdgeInsets.zero,
            child: Drawer(
              child: Padding(
                padding: EdgeInsets.zero,
                child: ListView(
                  children: [
                    buildDrawer(
                      SocialCubit.get(context).userModel!,
                    ),
                    ListTile(
                      leading: Icon(Icons.save),
                      title: Text(
                        'Saving',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text(
                        'mod',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.notification_important_rounded),
                      title: Text(
                        'Request',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        'LOGOUT',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      onTap: () {
                         logOuts(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildDrawer(SocialUserModel userModel) => UserAccountsDrawerHeader(
        accountName: Text(
          '${userModel.name}',
          style: TextStyle(fontSize: 16),
        ),
        accountEmail: Text(
          '${userModel.email}',
          style: TextStyle(fontSize: 16),
        ),
        currentAccountPicture: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              '${userModel.image}',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  '${userModel.cover}',
                ),
                fit: BoxFit.cover)),
      );
}
