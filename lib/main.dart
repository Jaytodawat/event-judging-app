import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/screens/create_team.dart';
import 'package:judge_assist_app/features/presentation/screens/event_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'features/presentation/screens/AdminHomeScreen.dart';



void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => EventListModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0F0F1F),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1D1D2F),
        )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Judge Assist',
      home: AdminHomeScreen(),
    );
  }
}
