import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/todo_app/cubit/cubit.dart';

import 'package:flutter_appp/Layout/todo_app/cubit/state.dart';

import 'package:flutter_appp/shared/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
      if (state is AppInsertDatabaseState) {
        Navigator.pop(context);
      }
    }, builder: (BuildContext context, state) {
      AppCubit cubit = AppCubit.get(context);

      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            cubit.titles[cubit.currentIndex],
          ),
        ),
        body: ConditionalBuilder(
          condition: state is! AppGetDatabaseLoadingState,
          builder: (context) => cubit.screens[cubit.currentIndex],
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (cubit.isBottomSheetShown) {
              if (formKey.currentState!.validate()) {
                cubit.insertToDatabase(
                  title: titleController.text,
                  date: dateController.text,
                  time: timeController.text,
                );
              }
            } else {
              scaffoldKey.currentState!
                  .showBottomSheet(
                    (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        20.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaulttextformfield(
                              controller: titleController,
                              type: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'title must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaulttextformfield(
                              controller: timeController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'time must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaulttextformfield(
                              controller: dateController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-05-03'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'date must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Date',
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                  .closed
                  .then((value) {
                cubit.changeBottomSheetState(
                  isShow: false,
                  icon: Icons.add,
                );
              });

              cubit.changeBottomSheetState(isShow: true, icon: Icons.remove);
            }
          },
          child: Icon(
            cubit.fabIcon,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outline,
              ),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_outlined,
              ),
              label: 'Archived',
            ),
          ],
        ),
      );
    });
  }
}
