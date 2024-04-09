import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/update_team.dart';
import 'package:judge_assist_app/features/presentation/widgets/custom_buttons.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/widgets/team_card.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  const EventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final List<Event> events = Provider.of<EventListModel>(context).events;
    final List<Team> teams = event.teams;
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
          child: teams.isEmpty
              ? const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(color: Colors.grey, fontSize: 24),
                  ),
                )
              : Consumer<EventListModel>(
                  builder: (context, eventListModel, _) => ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      Team team = teams[index];
                      return TeamCard(
                        team: team,
                        event: event,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTeamScreen(event: event, team: team),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
