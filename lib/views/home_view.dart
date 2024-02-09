import 'package:crud_app_dio/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          controller.fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
