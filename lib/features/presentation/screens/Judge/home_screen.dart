import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/event_screen.dart';
import 'package:judge_assist_app/features/presentation/widgets/event_card.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Event.dart';
import '../../../domain/entities/Team.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.judgeId});
  final int judgeId;
  @override
  Widget build(BuildContext context) {
    final List<Event> eventList = Provider.of<EventListModel>(context).events;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Events',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<EventListModel>(
            builder: (context, eventListModel, _) => ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                Event event = eventList[index];
                return EventCard(
                  event: event,
                  onTap: () async {
                    List<Team> teamList = await Provider.of<EventListModel>(context, listen: false).getTeams(event.teams);
                    if(context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventScreen(
                                event: event,
                                teams: teamList,
                                judgeId:judgeId
                              ),
                        ),
                      );
                    }
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
