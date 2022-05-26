import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/State.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/cubit.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return articleBuilder(list, context);
      },
    );
  }
}
