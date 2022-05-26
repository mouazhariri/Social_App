import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/shop_app/cubit/cubit.dart';
import 'package:flutter_appp/Layout/shop_app/cubit/states.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataStates)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaulttextformfield(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaulttextformfield(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaulttextformfield(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultbutton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                        token = model.data!.token;
                      }
                      return null;
                    },
                    text: 'Update',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultbutton(
                    background: Colors.indigo,
                    function: () {
                      logOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
