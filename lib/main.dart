import 'package:flutter/material.dart';
import 'package:interview_task_responsive_layout/features/users/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'features/users/providers/user_provider.dart';
import 'features/users/views/users_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider()..loadUsers()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/users': (_) => UsersListPage(),
      },
      home: SplashPage(),
      // home: UsersListPage(),
    );
  }
}
