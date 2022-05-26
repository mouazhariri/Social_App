import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/State.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appp/search/search_screen.dart';
import 'package:flutter_appp/shared/Network/remote/dio_helper.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/dark_light(toggle).dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                  'Today NEws'
              ),
            ),
            actions: [IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search))],
            leading: IconButton(icon:Icon(Icons.brightness_4_outlined),onPressed: (){
              ModeChangeCubit.get(context).appChangeMode();
            },),
          ),
          body:

          cubit.screen[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
