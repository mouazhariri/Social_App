// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
// import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
// import 'package:flutter_appp/shared/components/components.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SocialScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Center(
//                 child: Text(
//                   'Home',
//                 )),
//           ),
//           body: ConditionalBuilder(
//             condition: true,
//             builder: (context) {
//               var modell = SocialCubit.get(context).model;
//
//               return Column(
//                 children: [
//                   if (!FirebaseAuth.instance.currentUser.emailVerified)
//                     Container(
//                       color: Colors.amber.withOpacity(.6),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Row(
//                           children: [
//                             Icon(Icons.info_outline),
//                             SizedBox(width: 15),
//                             Expanded(child: Text('Please verify your email')),
//                             Spacer(),
//                             SizedBox(
//                               width: 25,
//                             ),
//                             defaultTextButton(
//                                 function: () {
//                                   FirebaseAuth.instance.currentUser
//                                       .sendEmailVerification()
//                                       .then((value) {
//                                     showToast(
//                                         message: 'check your mail',
//                                         state: toastState.Success);
//                                   }).catchError((error) {});
//                                 },
//                                 text: 'SEND'),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//             fallback: (context) => Center(child: CircularProgressIndicator()),
//           ),
//         );
//       },
//     );
//   }
// }
