import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/social_app/HomePage/HomePage.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconDam.Arrow___Left),
          onPressed: () {
            navigateToAndFinish(context, SocialScreen());
          },
        ),
        title: Text('Add Your Post'),
      ),
    );
  }
}
