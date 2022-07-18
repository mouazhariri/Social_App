import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/social_app/Register/register/cubit/cubit.dart';
import 'package:flutter_appp/modules/social_app/Register/register/cubit/states.dart';

import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';

import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class socialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => socialRegisterCubit(),
      child: BlocConsumer<socialRegisterCubit, socialRegisterStates>(
        listener: (context, state) {
          if (state is socialRegisterErrorStats) {
            showToast(message: state.error, state: toastState.Error);
          }
          if (state is SocialUserCreateSuccessStats) {
            navigateToAndFinish(context, SocialScreen());
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
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to to Communicate with our friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaulttextformfield(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaulttextformfield(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaulttextformfield(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: socialRegisterCubit.get(context).suffix,
                          onSubmitted: (value) {},
                          ispasswoard:
                              socialRegisterCubit.get(context).isPassword,
                          suffixpressed: () {
                            socialRegisterCubit
                                .get(context)
                                .changePasswordVisibility();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaulttextformfield(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! socialRegisterLoadingStats,
                          builder: (context) => defaultbutton(
                             background: Colors.green,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                socialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                              }
                            },
                            text: 'register',
                            isUppercase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
