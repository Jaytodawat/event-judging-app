import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/AddTeam.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/team_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Event.dart';
import '../../../domain/entities/Team.dart';
import '../../providers/event_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/team_card.dart';

class EventTeamScreen extends StatelessWidget {
  final Event event;
  const EventTeamScreen({super.key, required this.event});

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
                  return TeamCard(team: team, event: event, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamDetailScreen(team: team),
                      ),
                    );
                  },);
                }),
          ),
        ),
        bottomNavigationBar: RoundedButton(
          text: "Add Team",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTeam(event: event,),
              ),
            );
          },
        ),
      ),
    );
  }
}
