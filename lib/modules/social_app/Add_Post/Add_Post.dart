import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/social_app/HomePage/HomePage.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddPost extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // if (state is SocialCreatePostSuccessStates) {
        //   SocialCubit.get(context).getPost();
        //   SocialCubit.get(context).getpostsnumber();
        //
        //   SocialCubit.get(context).removePostImage();
        //   Navigator.pop(context);
        // }
      },
      builder: (context, state) {
        var postImage = SocialCubit.get(context).postImage;
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconDam.Arrow___Left_2),
              onPressed: () {
                navigateToAndFinish(context, SocialScreen());
                // SocialCubit.get(context).removePostImage();
              },
            ),
            title: Text('Add Your Post'),
            actions: [
              defaultTextButton(
                  function: () {
                    // var now = DateTime.now();
                    var now =
                        DateFormat('yyyy/MM/dd hh:mm a').format(DateTime.now());

                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  text: 'Post'),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${userModel!.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          '${userModel.name}',
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                ]),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Write what round in your brain ..',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              7.0,
                            ),
                            topRight: Radius.circular(
                              7.0,
                            ),
                          ),
                          image: DecorationImage(
                            image: FileImage(postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 14,
                              )))
                    ],
                  ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconDam.Image_2),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('#   Tags'),
                      ),
                    ),
                  ],
                ),
                if (state is SocialCreatePostLoadingStates)
                  LinearProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.greenAccent,
                  ),
                if (state is SocialCreatePostLoadingStates)
                  SizedBox(
                    height: 10,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
