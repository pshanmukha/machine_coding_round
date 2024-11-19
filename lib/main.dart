import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agenda/agenda_screen.dart';
import 'auth/auth_provider.dart';
import 'auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Agenda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const LoginScreen(),
          '/agenda': (context) => const AgendaScreen(),
        },
      ),
    );
  }
}

