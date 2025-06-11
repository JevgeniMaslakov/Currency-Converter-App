import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: user == null
            ? ElevatedButton(
          onPressed: () async {
            final result = await auth.signInWithGoogle();
            if (result != null) {
              setState(() {}); // обновляем UI
            }
          },
          child: const Text("Войти через Google"),
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
              radius: 40,
            ),
            const SizedBox(height: 10),
            Text(user.displayName ?? 'Без имени'),
            Text(user.email ?? ''),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
                setState(() {});
              },
              child: const Text("Выйти"),
            ),
          ],
        ),
      ),
    );
  }
}
