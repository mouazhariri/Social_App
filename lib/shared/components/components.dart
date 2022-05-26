import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_appp/shared/styles/Icon_Dam.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultbutton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUppercase = true,
  double radius = 30.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
//////////////////////////
Widget defaultTextButton({
  required Function function,
  required String text,
  Color color = Colors.green,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );
//////////////////////////////

Widget defaulttextformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmitted,
  ValueChanged? onChanged,
  bool ispasswoard = false,
  required Function validator,
  Function? onTap,
  bool isClickable = true,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixpressed,
}) =>

//space text ready
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmitted!(s);
      },
      onChanged: onChanged,
      obscureText: ispasswoard,
      onTap: () {
        onTap;
      },
      enabled: isClickable,
      validator: (s) {
        validator(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  suffixpressed!();
                },
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );





//space item
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[200],
      ),
    );





//push to next page
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
//push and finish
void navigateToAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

void showToast({
  required String message,
  toastState? state,
  Color? textColor,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(state!),
        textColor: Colors.white,
        fontSize: 16.0);
//enum
enum toastState { Success, Error, Warning }
Color choseToastColor(toastState state) {
  Color color;
  switch (state) {
    case toastState.Success:
      color = Colors.green;
      break;
    case toastState.Error:
      color = Colors.red;
      break;
    case toastState.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

/////////////////////////

//////////////////////////

buildAppbar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
  Widget? leading,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconDam.Arrow___Left_2),
      ),
      title: Text(title ?? ''),
      actions: actions,
    );
