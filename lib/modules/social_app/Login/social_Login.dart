import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/social_app/Login/cubit/cubit.dart';
import 'package:flutter_appp/modules/social_app/Login/cubit/states.dart';
import 'package:flutter_appp/modules/social_app/Register/register/register.dart';
import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLogin extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => socialLoginCubit(),
      child: BlocConsumer<socialLoginCubit, socialLoginStates>(
        listener: (context, state) {
          if (state is socialLoginErrorStats) {
            showToast(message: state.error, state: toastState.Error);
          }
          if (state is socialLoginSuccessStats) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateToAndFinish(context, SocialScreen());
            }).catchError((error) {
              print(error.toString());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black),
                          // TextStyle(
                          //   color: Colors.black,
                          //   fontSize: 40.0,
                          //   fontWeight: FontWeight.w700,
                          // ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login Now to Communicate with our friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaulttextformfield(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must be not empty';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaulttextformfield(
                            controller: passwordController,
                            ispasswoard:
                                socialLoginCubit.get(context).isPassword,
                            suffix: socialLoginCubit.get(context).suffix,
                            suffixpressed: () {
                              socialLoginCubit
                                  .get(context)
                                  .changeVisibilityPassword();
                            },
                            type: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline_rounded),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! socialLoginLoadingStats,
                          builder: (context) => defaultbutton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  socialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              background: Colors.green,
                              text: 'LOGIN'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, socialRegisterScreen());
                                },
                                child: Text(
                                  'ReGiSTeR',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
