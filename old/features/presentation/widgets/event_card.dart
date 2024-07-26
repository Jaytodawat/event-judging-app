import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/event_screen.dart';

import '../../../constants.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final void Function() onTap;
  const EventCard(
      {super.key,
      required this.event,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Material(
          color: const Color(0xFF1D1D2F),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((event.id).toString(),
                style: kEventCardStyle
                ),
                Text(event.name.toString(),
                style: kEventCardStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Text("${event.teams.length} teams",style: kEventCardStyle,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
