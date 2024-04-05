import 'package:flutter/material.dart';
import 'package:flutter_3/controller/profile_controller.dart';
import 'package:flutter_3/model/user_profile.dart';
import 'package:flutter_3/ui/body_widget.dart';
import 'package:flutter_3/ui/home.dart';
import 'package:provider/provider.dart';

void main() {
  final initial = UserProfile(
    name: 'Anna Avetysian',
    birthday: DateTime(1987, 9, 7, 17),
    phone: null,
    instagram: null,
    email: 'info_anna@design.com',
    password: 'password123',
  );
  runApp(ChangeNotifierProvider(
    create: (_) => UserProfileNotifier(initial),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            prefixIconColor: Colors.deepPurple,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
      home: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PaintedAppBar(),
      body: Body(),
    );
  }
}
