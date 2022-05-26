import 'package:flutter/material.dart';

import 'package:flutter_appp/Layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appp/Layout/todo_app/cubit/state.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return tasksBuilder(
            tasks: tasks,
          );
        });
  }
}
