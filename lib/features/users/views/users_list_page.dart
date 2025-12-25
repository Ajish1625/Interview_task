import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/bottom_nav.dart';
import '../providers/user_provider.dart';
import '../../../shared/widgets/user_card.dart';
import 'add_user_page.dart';

class UsersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsersProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Icon(Icons.layers, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text('Minia', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: 'Add User',
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddUserPage(),
                ),
              );

              if (result == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User added successfully ✅'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },

          ),
        ],
      ),


        bottomNavigationBar: BottomNav(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search),

              ),

              onChanged: provider.search,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return const Center(
                    child: Text('Oops! Something went wrong 😢'),
                  );
                }

                return ListView.builder(
                  itemCount: provider.filteredUsers.length,
                  itemBuilder: (_, i) {
                    final user = provider.filteredUsers[i];
                    return UserCard(user: user);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
