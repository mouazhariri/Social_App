import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/comment_model.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  final String uIdComm;

  CommentsScreen({Key? key, required this.uIdComm}) : super(key: key);

  final commentController = TextEditingController();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getComment(postId: uIdComm);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Comments'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (SocialCubit.get(context).commentsModel != 0)
                    ConditionalBuilder(
                      condition:
                          SocialCubit.get(context).commentsModel.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCommentItem(context,
                                SocialCubit.get(context).commentsModel[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 2,
                          ),
                          itemCount:
                              SocialCubit.get(context).commentsModel.length,
                        ),
                      ),
                      fallback: (context) => Expanded(
                          child: Center(
                              child: Text(
                        'No comments...',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ))),
                    ),
                  buildWriteCommentRow(context),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  buildCommentItem(context, CommentModel comment) {
    var commentImage = SocialCubit.get(context).commentImage;

    return Column(
      children: [
        if (SocialCubit.get(context).commentImage != null)
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
                    image: FileImage(commentImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    SocialCubit.get(context).removeCommentImage();
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  '${comment.image}',
                ),
                radius: 22,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(
                                  '${comment.name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${comment.dateTime}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Spacer(),
                                if (comment.userid ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                  PopupMenuButton(
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry>[
                                      PopupMenuItem(
                                        height: 7,
                                        onTap: () {},
                                        child: TextButton(
                                            child: Text('remove'),
                                            onPressed: () {
                                              SocialCubit.get(context)
                                                  .deletesinglecomment(
                                                      comment.postId!,
                                                      comment.commentId!);
                                              Navigator.pop(context);
                                            }),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                          myDivider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '${comment.textComment}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildWriteCommentRow(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    SocialCubit.get(context).getCommentImage();
                  },
                  icon: Icon(IconDam.Camera),
                ),
                hintText: 'Write your comment..',
                border: InputBorder.none,
              ),
              controller: commentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 16),
              cursorHeight: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              if (SocialCubit.get(context).commentImage == null) {
                SocialCubit.get(context).writeComment(
                  name: SocialCubit.get(context).userModel!.name!,
                  dateTime: TimeOfDay.now().format(context),
                  text: commentController.text,
                  postId: uIdComm,
                  userid: SocialCubit.get(context).userModel!.uId!,
                );
              } else
                (SocialCubit.get(context).uploadCommentImage(
                    dateTime: TimeOfDay.now().format(context),
                    text: commentController.text,
                    uId: uIdComm,
                    postId: SocialCubit.get(context).userModel!.uId!,
                    name: SocialCubit.get(context).userModel!.name!));
              commentController.clear();
            },
            icon: Transform.translate(
              offset: const Offset(10, 0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
