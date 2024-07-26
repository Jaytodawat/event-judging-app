import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/add_judge.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/add_team.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/team_detail_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/winner_list_screen.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/Event.dart';
import '../../../domain/entities/Team.dart';
import '../../providers/event_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/team_card.dart';

class EventTeamScreen extends StatelessWidget {
  final Event event;
  final List<int> teams;
  const EventTeamScreen({super.key, required this.event, required this.teams});

  @override
  Widget build(BuildContext context) {
    var eventListModel = Provider.of<EventListModel>(context, listen: true);
    Future<void> refreshEvents() async {
      await eventListModel.refresh(); // Call the method to fetch events again
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            event.name,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.emoji_events), // Icon for the button
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WinnerListScreen(
                        eventId: event.id), // Navigate to WinnerPage
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: RefreshIndicator(
            onRefresh: () => refreshEvents(),
            child: FutureBuilder<List<Team>>(
              future: eventListModel.getTeams(teams),
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
                  final teamList = snapshot.data!;
                  return ListView.builder(
                    itemCount: teamList.length,
                    itemBuilder: (context, index) {
                      final team = teamList[index];
                      return TeamCard(
                        team: team,
                        event: event,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamDetailsScreen(
                                teamId: team.id,
                                parameters: event.parameterId,
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
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RoundedButton(
              text: "Add Team",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTeam(
                      event: event,
                    ),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Add Judge",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddJudge(
                      event: event,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


