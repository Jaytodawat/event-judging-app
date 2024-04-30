import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/data/datasource/api_service.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/add_team.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/create_event_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/LoginScreen.dart';
// import 'package:judge_assist_app/features/presentation/screens/create_team.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/event_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/judge_home_screen.dart';
import 'package:provider/provider.dart';

import 'features/presentation/screens/Admin/admin_home_screen.dart';

void main() {
  final Dio dio = Dio();
  runApp(
    ChangeNotifierProvider(
      create: (_) => EventListModel(apiService: ApiService(dio)),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF0F0F1F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF1D1D2F),
              iconTheme: IconThemeData(
                color: Colors.white, // Change this color to your desired color
              ),
            )),
        debugShowCheckedModeBanner: false,
        title: 'Judge Assist',
        home: const LoginScreen(),
      ),
    );
  }
}
