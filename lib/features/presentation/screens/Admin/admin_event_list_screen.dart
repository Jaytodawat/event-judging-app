import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/CreateEventScreen.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_teams_screen.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Event.dart';
import '../../providers/event_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/event_card.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventTeamScreen(
                          event: event,
                        ),
                      ),
                    );
                  },
                );
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
                builder: (context) => CreateEventScreen(),
              ),
            );
          },
        ),
      ),

    );
  }
}
