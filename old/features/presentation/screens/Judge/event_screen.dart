import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/update_team.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/widgets/team_card.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  final List<int> teams;
  final int judgeId;
  const EventScreen({super.key, required this.event, required this.teams, required this.judgeId});

  @override
  Widget build(BuildContext context) {
    var eventListModel = Provider.of<EventListModel>(context, listen: true);
    Future<void> refreshEvents() async {
      await eventListModel.getTeams(teams); // Call the method to fetch events again
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            event.name,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
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
                              builder: (context) => UpdateTeamScreen(
                                event: event, team: team, judgeId : judgeId,
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
      ),
    );
  }
}





// class EventScreen extends StatelessWidget {
//   final Event event;
//   final List<Team> teams;
//   final int judgeId;
//   const EventScreen({super.key, required this.event, required this.teams, required this.judgeId});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Event> events = Provider.of<EventListModel>(context).events;
//     // final List<Team> teams = event.teams;
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             event.name,
//             style: const TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: teams.isEmpty
//               ? const Center(
//                   child: Text(
//                     'No Data',
//                     style: TextStyle(color: Colors.grey, fontSize: 24),
//                   ),
//                 )
//               : Consumer<EventListModel>(
//                   builder: (context, eventListModel, _) => ListView.builder(
//                     itemCount: teams.length,
//                     itemBuilder: (context, index) {
//                       Team team = teams[index];
//                       return TeamCard(
//                         team: team,
//                         event: event,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateTeamScreen(event: event, team: team, judgeId : judgeId, ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
