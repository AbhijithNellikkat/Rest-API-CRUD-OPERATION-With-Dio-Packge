// ignore_for_file: use_build_context_synchronously

import 'package:crud_app_dio/controllers/user_controller.dart';
import 'package:crud_app_dio/views/create_user_view.dart';
import 'package:crud_app_dio/views/update_user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crud App'),
      ),
      body: controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  UpdateUserView(user: user),
                    ));
                  },
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text("${user.name}"),
                  subtitle: Text("${user.email}"),
                  trailing: IconButton(
                    onPressed: () async {
                      bool deleted = await Provider.of<UserController>(context,
                              listen: false)
                          .deleteUser(user.id);
                      if (deleted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User deleted successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to delete user'),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateUserView(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
