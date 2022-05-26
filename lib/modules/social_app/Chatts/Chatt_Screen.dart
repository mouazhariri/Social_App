import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/Chat_model.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatScreen({required this.userModel});
  var messageController = TextEditingController();
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).message.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messages =
                                  SocialCubit.get(context).message[index];
                              if (SocialCubit.get(context).userModel!.uId ==
                                  messages.senderId)
                                return buildMyMessage(messages);

                              return buildMessage(messages);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                            itemCount: SocialCubit.get(context).message.length),
                      ),
                      Container(
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write your message...',
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.green,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId!,
                                      dateTime: Timestamp.now().toString(),
                                      text: messageController.text);
                                  messageController.clear();
                                },
                                child: Icon(
                                  IconDam.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(ChatModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
            color: Colors.grey[300],
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(model.text!)),
    );
Widget buildMyMessage(ChatModel model) => Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
              color: Colors.green.withOpacity(.5)),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          // color: Colors.green.withOpacity(.1),
          child: Text(model.text!)),
    );
