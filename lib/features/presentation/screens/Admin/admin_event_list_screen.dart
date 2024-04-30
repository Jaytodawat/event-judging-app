import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/providers/auth_provider.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/create_event_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_teams_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Event.dart';
import '../../providers/event_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/event_card.dart';


class AdminEventListScreen extends StatelessWidget {
  const AdminEventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var eventListModel = Provider.of<EventListModel>(context, listen: true);
    Auth auth = Auth();
    Future<void> refreshEvents() async {
      await eventListModel.refresh(); // Call the method to fetch events again
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Events',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () async {
                await auth.clearLoginInfo();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RefreshIndicator(
            onRefresh: () => refreshEvents(),
            child: FutureBuilder<List<Event>>(
              future: eventListModel.getAllEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  String errorMessage = '';
                  if (snapshot.error is Exception) {
                    final error = snapshot.error as Exception;
                    if (error is DioException) {
                      if (error.response?.statusCode == 400) {
                        errorMessage = 'Wrong input';
                      } else if (error.response?.statusCode == 502) {
                        errorMessage = 'Server down';
                      } else {
                        // print(error.response?.statusCode);
                        errorMessage = 'Unknown error';
                      }
                    } else {
                      // print(error.response?.statusCode);
                      errorMessage = 'Unknown error';
                    }
                  } else {
                    // print(snapshot.error.response?.statusCode);
                    errorMessage = 'No Team Judged Yet in this event';
                  }
                  return Center(
                    child: Text(
                      'Failed To Load Data : $errorMessage',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  final eventList = snapshot.data!;
                  return ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      final event = eventList[index];
                      return EventCard(
                        event: event,
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventTeamScreen(
                                event: event,
                                teams: event.teams,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: RoundedButton(
          text: "Create Event",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateEventScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
