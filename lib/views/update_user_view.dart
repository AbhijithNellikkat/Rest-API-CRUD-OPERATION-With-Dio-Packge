// ignore_for_file: use_build_context_synchronously

import 'package:crud_app_dio/controllers/user_controller.dart';
import 'package:crud_app_dio/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserView extends StatefulWidget {
  final Users user;
  const UpdateUserView({
    super.key,
    required this.user,
  });

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 55),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneNumberController,
                    maxLength: 10,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                  const SizedBox(height: 1),
                  ElevatedButton(
                    onPressed: () async {
                      Users updatedUser = Users(
                        id: widget.user.id,
                        name: nameController.text,
                        email: emailController.text,
                        phoneNumber: phoneNumberController.text,
                      );

                      bool edited = await Provider.of<UserController>(context,
                              listen: false)
                          .editUser(user: updatedUser);

                      if (edited) {
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to edit user'),
                          ),
                        );
                      }
                    },
                    child: const Text(" Submit "),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
