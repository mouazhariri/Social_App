// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
// import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
// import 'package:flutter_appp/models/social_model/Post_model.dart';
// import 'package:flutter_appp/models/social_model/social_model.dart';
// import 'package:flutter_appp/modules/social_app/Add_Post/Add_Post.dart';
// import 'package:flutter_appp/modules/social_app/Chatts/Chatt_Screen.dart';
// import 'package:flutter_appp/modules/social_app/comment/comments.dart';
// import 'package:flutter_appp/shared/components/components.dart';
// import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
// import 'package:flutter_appp/shared/styles/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   SocialUserModel? model;
//
//   var refreshController = RefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       SocialCubit.get(context).getUserData();
//       SocialCubit.get(context).getPost();
//       return BlocConsumer<SocialCubit, SocialState>(
//         listener: (context, state) {
//           // if (state is SocialSuccessHomeStates) {
//           //   SocialCubit.get(context).getPost();
//           // }
//         },
//         builder: (context, state) {
//           return ConditionalBuilder(
//             condition: SocialCubit.get(context).modelPost.length > 0 &&
//                 SocialCubit.get(context).userModel != null,
//             builder: (context) {
//               return SmartRefresher(
//                 physics: BouncingScrollPhysics(),
//                 controller: refreshController,
//                 onRefresh: onRefresh,
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           navigateTo(context, AddPost());
//                         },
//                         child: Card(
//                           clipBehavior: Clip.antiAliasWithSaveLayer,
//                           elevation: 10.0,
//                           margin: EdgeInsets.all(8),
//                           child: Stack(
//                               alignment: AlignmentDirectional.topStart,
//                               children: [
//                                 Image(
//                                   image: AssetImage(
//                                       'assets/images/social/social_person.jpg'),
//                                   fit: BoxFit.fill,
//                                   height: 200.0,
//                                   width: double.infinity,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'What\'s on your mind',
//                                     style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.white),
//                                   ),
//                                 )
//                               ]),
//                         ),
//                       ),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) => buildPostItem(
//                             SocialCubit.get(context).modelPost[index],
//                             context,
//                             index),
//                         separatorBuilder: (context, index) => SizedBox(
//                           height: 10,
//                         ),
//                         itemCount: SocialCubit.get(context).modelPost.length,
//                       ),
//                       SizedBox(
//                         height: 15,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//             fallback: (context) => Center(child: CircularProgressIndicator()),
//           );
//         },
//       );
//     });
//   }
//
//   Future<void> onRefresh() async {
//     await Future.delayed(Duration(seconds: 1)).then((value) {
//       SocialCubit.get(context).getUserData();
//       SocialCubit.get(context).getPost();
//       refreshController.refreshCompleted();
//     });
//   }
//
//   Widget buildPostItem(PostModel model, context, index) => Card(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         elevation: 8,
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 25.0,
//                     backgroundImage: NetworkImage('${model.image}'),
//                   ),
//                   SizedBox(
//                     width: 15.0,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               '${model.name}',
//                               style: TextStyle(height: 1.4),
//                             ),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             Icon(
//                               Icons.check_circle,
//                               color: defaultColor,
//                               size: 16.0,
//                             )
//                           ],
//                         ),
//                         Text(
//                           '${model.dateTime}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .caption!
//                               .copyWith(height: 1.4),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15.0,
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         IconDam.More_Circle,
//                         size: 18,
//                       ))
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 child: Container(
//                   width: double.infinity,
//                   height: 1.0,
//                   color: Colors.grey[300],
//                 ),
//               ),
//               Text(
//                 '${model.text}',
//                 style: Theme.of(context).textTheme.bodyText2,
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.only(
//                   bottom: 10.0,
//                   top: 5.0,
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   child:
//                       //create new line automatic(wrap)
//                       Wrap(children: [
//                     Padding(
//                       padding: const EdgeInsetsDirectional.only(end: 8.0),
//                       child: Container(
//                         height: 25,
//                         child: MaterialButton(
//                           onPressed: () {},
//                           minWidth: 1,
//                           padding: EdgeInsets.zero,
//                           child: Text(
//                             '#Software_Development',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption!
//                                 .copyWith(color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
//               if (model.PostImage != '')
//                 Padding(
//                   padding: const EdgeInsetsDirectional.only(top: 15),
//                   child: Container(
//                     height: 150,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         image: DecorationImage(
//                           image: NetworkImage('${model.PostImage}'),
//                           fit: BoxFit.fill,
//                         )),
//                   ),
//                 ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                 '${SocialCubit.get(context).Like[index]}',
//                                 style: Theme.of(context).textTheme.caption,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 IconDam.Heart,
//                                 size: 18,
//                                 color: Colors.red,
//                               )
//                             ],
//                           ),
//                         ),
//                         onTap: () {},
//                       ),
//                     ),
//                     InkWell(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Icon(
//                             IconDam.Chat,
//                             size: 18,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '${SocialCubit.get(context).commentsNumber[index]} Comments',
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         navigateTo(
//                             context,
//                             CommentsScreen(
//                               uIdComm:
//                                   SocialCubit.get(context).postComments[index],
//                             ));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               //liner
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 1.0,
//                   color: Colors.grey[300],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 15.0,
//                             backgroundImage: NetworkImage(
//                                 '${SocialCubit.get(context).userModel!.image}'),
//                           ),
//                           SizedBox(
//                             width: 15.0,
//                           ),
//                           Text(
//                             'write a comment...',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption!
//                                 .copyWith(height: 1.4),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         navigateTo(
//                             context,
//                             CommentsScreen(
//                               uIdComm:
//                                   SocialCubit.get(context).postComments[index],
//                             ));
//                       },
//                     ),
//                   ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.recommend,
//                             size: 20,
//                             color: Colors.blue,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             'Like',
//                             style: Theme.of(context).textTheme.caption,
//                           )
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       SocialCubit.get(context)
//                           .likePost(SocialCubit.get(context).postId[index]);
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.ios_share,
//                             size: 20,
//                             color: Colors.green,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             'share',
//                             style: Theme.of(context).textTheme.caption,
//                           )
//                         ],
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
// }
