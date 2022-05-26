
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/State.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/cubit.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state) {
  var list = NewsCubit.get(context).search;
  return Scaffold(

  appBar: AppBar(),
  body: Column(
  children: [
  Padding(
  padding: const EdgeInsets.all(20.0),
  child: defaulttextformfield(
  controller: searchController,
  onChanged: (value){
    NewsCubit.get(context).getSearch(value);
  },

  validator: (String value){
    if(value.isEmpty){
      return 'search must be not empty';}
    return null;
    },


  type: TextInputType.text,
  label: 'search',
  prefix: Icons.search,
  ),
  ),
  Expanded(child: articleBuilder(list, context,isSearch: true)),
  ],
  ),
  );
  });
      }

}
