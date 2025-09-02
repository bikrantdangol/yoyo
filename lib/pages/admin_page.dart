// admin_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  // Sign out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ADMIN DASHBOARD',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Logged in as: ${user?.email ?? 'Admin'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Add admin-specific functionality here
            ElevatedButton(
              onPressed: () {
                // Add admin functionality
              },
              child: const Text('Manage Users'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Add admin functionality
              },
              child: const Text('View Statistics'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Add admin functionality
              },
              child: const Text('System Settings'),
            ),
          ],
        ),
      ),
    );
  }
}