import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UsersProvider>().getById(userId);

    return Scaffold(
      backgroundColor: Colors.grey[100], // Subtle background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(user.name, style: TextStyle(color: Colors.black)), // Title text color
        actions: [
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Name: ${user.name}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Email Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text("Email: ${user.email}", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Phone Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text("Phone: ${user.phone}", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Address Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text("Address: ${user.address.fullAddress}", style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Company Section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Company:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Name: ${user.company.name}", style: Theme.of(context).textTheme.bodyMedium),
                    Text("Catch Phrase: ${user.company.catchPhrase}", style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}