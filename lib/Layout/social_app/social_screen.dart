import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/modules/social_app/Add_Post/Add_Post.dart';
import 'package:flutter_appp/modules/social_app/Login/social_Login.dart';
import 'package:flutter_appp/modules/social_app/drawer/drawer.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialAddPostStates) {
          navigateTo(context, AddPost());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          drawer: drawer(),
          appBar: AppBar(actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(IconDam.Notification),
                color: tcolor),
            IconButton(
              onPressed: () {},
              icon: Icon(IconDam.Search),
              color: tcolor,
            ),
          ], title: Center(child: Text(cubit.titles[cubit.currentIndex]))),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.currentIndex,
            height: 55.0,
            items: <Widget>[
              Icon(
                IconDam.Home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                IconDam.Chat,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.add_to_photos_sharp,
                size: 40,
                color: Colors.black38,
                semanticLabel: 'Add post',
              ),
              Icon(
                Icons.supervised_user_circle_outlined,
                size: 30,
                color: Colors.white,
                semanticLabel: 'Friends',
              ),
              Icon(Icons.perm_identity, size: 30, color: Colors.white),
            ],
            color: Colors.greenAccent,
            buttonBackgroundColor: Colors.greenAccent,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOutBack,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            letIndexChange: (index) => true,
          ),

          // FluidNavBar(
          //   defaultIndex: cubit.currentIndex,
          //   icons: [
          //     FluidNavBarIcon(icon: IconDam.Home, extras: {'label': 'Home'}),
          //     FluidNavBarIcon(icon: IconDam.Chat),
          //     FluidNavBarIcon(
          //         icon: Icons.post_add_outlined,
          //         unselectedForegroundColor: Colors.black),
          //     FluidNavBarIcon(icon: Icons.location_history),
          //     FluidNavBarIcon(icon: IconDam.Setting),
          //   ],
          //   onChange: (index) {
          //     cubit.changeBottomNav(index);
          //   },
          //   style: FluidNavBarStyle(
          //       barBackgroundColor: tcolor,
          //       iconBackgroundColor: Color(0xffebe6c5),
          //       iconSelectedForegroundColor: tcolor,
          //       iconUnselectedForegroundColor: Colors.black12),
          // ),
        );
      },
    );
  }
}
