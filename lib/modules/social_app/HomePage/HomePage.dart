import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/Post_model.dart';
import 'package:flutter_appp/models/social_model/comment_model.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';

import 'package:flutter_appp/modules/social_app/Add_Post/Add_Post.dart';
import 'package:flutter_appp/modules/social_app/Chatts/Chatt_Screen.dart';
import 'package:flutter_appp/modules/social_app/Setting/Setting.dart';
import 'package:flutter_appp/modules/social_app/comment/comments.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/local_key.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late String currentUser;
  // late int likeCount;
  // late Map likes;
  // late bool isliked;

  SocialUserModel? model;
  var refreshController = RefreshController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);

    // isliked = (likes[currentUser] == true);
    return Builder(builder: (context) {
      // SocialCubit.get(context).getUserData();
      // SocialCubit.get(context).getPost();
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // if (state is SocialSuccessHomeStates) {
          //   // SocialCubit.get(context).getPost();
          //   // SocialCubit.get(context).getUserData();
          // }
        },
        builder: (context, state) {
          SocialUserModel? userModel = SocialCubit.get(context).userModel;
          List<PostModel> posts = SocialCubit.get(context).modelPost;
          return ConditionalBuilder(
            condition: SocialCubit.get(context).modelPost.length > 0 &&
                SocialCubit.get(context).userModel != null,
            builder: (context) {
              return Scaffold(
                key: scaffoldKey,
                body: SmartRefresher(
                  physics: BouncingScrollPhysics(),
                  controller: refreshController,
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            navigateTo(context, AddPost());
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 10.0,
                            margin: EdgeInsets.all(8),
                            child: Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/social/social_person.jpg'),
                                    fit: BoxFit.fill,
                                    height: 200.0,
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'What\'s on your mind',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                            SocialCubit.get(context).mylikedpostslist,
                            SocialCubit.get(context).modelPost[index],
                            SocialCubit.get(context).postId[index],
                            SocialCubit.get(context).postsLikesbymap,
                            SocialCubit.get(context).postsCommentbymap,
                            context,
                            index,
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: posts.length,
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      );
    });
  }

  // Future<bool> willPop() async {
  //   final shouldPop = await showDialog(
  //       context: context,
  //       builder: (context) => baseAlertDialog(
  //             context: context,
  //             title: LocaleKeys.exit.tr(),
  //             content: LocaleKeys.areYouSureExit.tr(),
  //             outlinedButtonText: 'Cancel',
  //             elevatedButtonText: LocaleKeys.exit.tr(),
  //             elevatedButtonIcon: Icons.exit_to_app_outlined,
  //           ));
  //   return shouldPop ?? false;
  // }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      SocialCubit.get(context).getUserData();
      SocialCubit.get(context).getPost();
      refreshController.refreshCompleted();
    });
  }

  // handleLikepost(
  //     SocialUserModel model, PostModel postModel, String postId, context) {
  //   final String? currentUsser = SocialCubit.get(context).currentUser.uId;
  //   currentUser == currentUsser;
  //   bool islikes = likes[currentUsser] == true;
  //   if (islikes) {
  //     FirebaseFirestore.instance
  //         .collection('Posts')
  //         .doc(postId)
  //         .update({'Like.${currentUsser}': false});
  //     setState(() {
  //       likeCount -= 1;
  //       isliked = false;
  //       likes[currentUsser] = false;
  //     });
  //   } else if (!islikes) {
  //     FirebaseFirestore.instance
  //         .collection('Posts')
  //         .doc(postId)
  //         .update({'Like.${currentUsser}': true});
  //     setState(() {
  //       likeCount += 1;
  //       isliked = true;
  //       likes[currentUsser] = true;
  //     });
  //   }
  // }
  bool click = false;
  Widget buildPostItem(
    List<String> mylikedpostslist,
    PostModel model,
    String postId,
    Map<String, int> likes,
    Map<String, int> comment,
    context,
    index,
    // SocialUserModel? userModel,
  ) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (model.uId != SocialCubit.get(context).userModel!.uId)
                        navigateTo(context, SocialProfile(uId: model.uId));
                      else
                        navigateTo(context, SocialProfile());
                    },
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {
                        if (model.uId == FirebaseAuth.instance.currentUser!.uid)
                          // scaffoldKey.currentState!.showBodyScrim(true, 0.5);
                          scaffoldKey.currentState!.showBottomSheet((context) =>
                              Card(
                                  color: Colors.white70,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      borderSide: BorderSide.none),
                                  elevation: 15,
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.drag_handle),
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${model.image}'),
                                              radius: 25,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${model.text}',
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '' +
                                                      'This Post was shared on[ ${model.dateTime} ]',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Spacer()
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            PopupMenuButton(
                                              icon: Icon(IconDam.Delete),
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      <PopupMenuItem>[
                                                PopupMenuItem(
                                                  height: 7,
                                                  onTap: () {},
                                                  child: TextButton(
                                                    child:
                                                        Text('Are you Sure!!'),
                                                    onPressed: () {
                                                      var alert = AlertDialog(
                                                        title: Center(
                                                            child: Text(
                                                          'Alert ! ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                        titlePadding:
                                                            EdgeInsets.all(10),
                                                        content: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 150,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  color: Colors
                                                                      .grey,
                                                                  child:
                                                                      SizedBox(
                                                                    height: 1,
                                                                    width: double
                                                                        .infinity,
                                                                  )),
                                                              SizedBox(),
                                                              Text(
                                                                  'are you sure you want to delete this post ?'),
                                                              Spacer(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'NO'),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      SocialCubit.get(context).deletepost(
                                                                          postId,
                                                                          context);

                                                                      showToast(
                                                                          message:
                                                                              'Delete <Successfully>',
                                                                          textColor:
                                                                              Colors.greenAccent);
                                                                      // Navigator.pop(
                                                                      //     context);
                                                                    },
                                                                    child: Text(
                                                                        'YES'),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          barrierColor: Colors
                                                              .grey
                                                              .withOpacity(.6),
                                                          barrierLabel:
                                                              'delete',
                                                          context: context,
                                                          builder: (context) =>
                                                              alert);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]))));
                      },
                      icon: Icon(
                        IconDam.More_Circle,
                        size: 18,
                      ))
                  // if (model.uId == FirebaseAuth.instance.currentUser!.uid)
                  //                     PopupMenuButton(
                  //                       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  //                         PopupMenuItem(
                  //                           height: 7,
                  //                           onTap: () {},
                  //                           child: TextButton(
                  //                             child: Text('remove'),
                  //                             onPressed: () {
                  //                               var alert = AlertDialog(
                  //                                 title: Text('Alert ! '),
                  //                                 titlePadding: EdgeInsets.all(10),
                  //                                 content: Container(
                  //                                   width: 150,
                  //                                   height: 150,
                  //                                   child: Column(
                  //                                     mainAxisAlignment: MainAxisAlignment.end,
                  //                                     crossAxisAlignment:
                  //                                         CrossAxisAlignment.center,
                  //                                     children: [
                  //                                       Container(
                  //                                           color: Colors.grey,
                  //                                           child: SizedBox(
                  //                                             height: 1,
                  //                                             width: double.infinity,
                  //                                           )),
                  //                                       SizedBox(),
                  //                                       Text(
                  //                                           'are you sure you want to delete the post ?'),
                  //                                       Spacer(),
                  //                                       Row(
                  //                                         mainAxisAlignment:
                  //                                             MainAxisAlignment.spaceAround,
                  //                                         children: [
                  //                                           ElevatedButton(
                  //                                             onPressed: () {
                  //                                               Navigator.pop(context);
                  //                                             },
                  //                                             child: Text('NO'),
                  //                                           ),
                  //                                           ElevatedButton(
                  //                                             onPressed: () {
                  //                                               SocialCubit.get(context)
                  //                                                   .deletepost(postId);
                  //                                               Navigator.pop(context);
                  //                                               showToast(
                  //                                                   message:
                  //                                                       'Delete Succefully><',
                  //                                                   textColor:
                  //                                                       Colors.greenAccent);
                  //                                             },
                  //                                             child: Text('YES'),
                  //                                           )
                  //                                         ],
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                               );
                  //                               Navigator.pop(context);
                  //                               // showDialog(
                  //                               //     barrierColor: Colors.grey.withOpacity(.6),
                  //                               //     barrierLabel: 'dsadsasadsadasdasdddsad',
                  //                               //     context: context,
                  //                               //     builder: (context) => alert);
                  //                             },
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 10.0,
                  top: 5.0,
                ),
                child: Container(
                  width: double.infinity,
                  child:
                      //create new line automatic(wrap)
                      Wrap(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#Software_Development',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              if (model.PostImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage('${model.PostImage}'),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Text(
                                likes[postId].toString(),
                                // '${SocialCubit.get(context).Like[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // if(SocialCubit.get(context).islike ==index )
                              Icon(IconDam.Heart,
                                  size: 18,
                                  color: likes[postId]! > 0
                                      ? Colors.greenAccent
                                      : Colors.grey)
                            ],
                          ),
                        ),
                        onTap: () {
                          // navigateTo(context, WhoLikedScreen(postModel.postId))
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              comment[postId].toString(),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            if (comment[postId] != 1)
                              Text(
                                'comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: comment[postId]! > 0
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                              )
                            else
                              Text(
                                'comment',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.blueAccent,
                                    ),
                              ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              IconDam.Chat,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        onTap: () {
                          // SocialCubit.get(context).getComment(postId);
                          navigateTo(
                              context,
                              CommentsScreen(
                                uIdComm: postId,
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //liner
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment...',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {
                        navigateTo(
                            context,
                            CommentsScreen(
                              uIdComm: postId,
                            ));
                      },
                    ),
                  ),
                  if (mylikedpostslist.contains(postId))
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            if (mylikedpostslist.contains(postId))
                              Icon(
                                // SocialCubit.get(context).isClick
                                Icons.favorite,
                                // Icons.favorite_border,
                                // isliked ? : Icons.favorite_border,
                                size: 20,
                                color:
                                    // SocialCubit.get(context).isClick
                                    Colors.greenAccent,
                                // Colors.grey,
                              ),
                            if (!mylikedpostslist.contains(postId))
                              Icon(
                                Icons.favorite,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'UN Like',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context).unlikePost(postId);
                        // SocialCubit.get(context).onPressed(model.uId);
                        // if (click == false) {
                        //   SocialCubit.get(context)
                        //       .likePost(userModel?.uId, click);
                        // } else {
                        //   SocialCubit.get(context)
                        //       .likePost(userModel?.uId, click);
                        // }
                        // click = !click;
                        // SocialCubit.get(context).likeUnlikePost(model.uId);
                        // handleLikepost;
                        // SocialCubit.get(context)
                        //     .likePost(SocialCubit.get(context).postId[index]);
                        // SocialCubit.get(context).isLike(index);
                      },
                    ),
                  if (!mylikedpostslist.contains(postId))
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              // SocialCubit.get(context).isClick
                              //      Icons.favorite,
                              Icons.favorite_border,
                              // isliked ? : Icons.favorite_border,
                              size: 20,
                              color:
                                  // SocialCubit.get(context).isClick
                                  //     ? Colors.greenAccent
                                  Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Like',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context).likePost(postId);
                        // SocialCubit.get(context).onPressed(model.uId);
                        // if (click == false) {
                        //   SocialCubit.get(context)
                        //       .likePost(userModel?.uId, click);
                        // } else {
                        //   SocialCubit.get(context)
                        //       .likePost(userModel?.uId, click);
                        // }
                        // click = !click;
                        // SocialCubit.get(context).likeUnlikePost(model.uId);
                        // handleLikepost;
                        // SocialCubit.get(context)
                        //     .likePost(SocialCubit.get(context).postId[index]);
                        // SocialCubit.get(context).isLike(index);
                      },
                    ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ios_share,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'share',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      );
  // Widget buildCommentItem(CommentModel model, context) {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             radius: 20,
  //             backgroundImage: NetworkImage(model.image!),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //                 color: Colors.blue[100],
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 5, bottom: 5, left: 5, right: 2.5),
  //                 child: Row(
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(model.name!,
  //                             style: TextStyle(
  //                                 fontSize: 13,
  //                                 color: Colors.grey,
  //                                 fontWeight: FontWeight.bold)),
  //                         SizedBox(
  //                           height: 3.5,
  //                         ),
  //                         Text(
  //                           model.textComment!,
  //                         ),
  //                       ],
  //                     ),
  //                     Spacer(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           if (model.uId == FirebaseAuth.instance.currentUser!.uid)
  //             Container(
  //               width: 20,
  //               child: IconButton(
  //                   onPressed: () {
  //                     SocialCubit.get(context)
  //                         .deletesinglecomment( model.,model.uId!);
  //                     Navigator.pop(context);
  //                   },
  //                   icon: Icon(Icons.delete_forever_outlined)),
  //             )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
