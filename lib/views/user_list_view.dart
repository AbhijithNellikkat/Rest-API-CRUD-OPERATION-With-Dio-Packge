import 'package:crud_app_dio/controllers/user_controller.dart';
import 'package:crud_app_dio/views/create_user_view.dart';
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
                  title: Text("${user.name}"),
                  subtitle: Text("${user.email}"),
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
