import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/presentation/screens/event_screen.dart';

import '../../../constants.dart';

class EventCard extends StatelessWidget {
  final int index;
  final Event event;
  final void Function() onTap;
  const EventCard(
      {super.key,
      required this.index,
      required this.event,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Material(
          color: Colors.white,
          // elevation: 1,
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
                Expanded(
                  // flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${event.id}',
                        style: kSubTextStyle.copyWith(
                            color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        event.name,
                        style: kSubTextStyle1.copyWith(fontSize: 14),
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(Icons.groups),
                      //     const SizedBox(
                      //         width:
                      //             8), // Adjust the spacing between the icon and text as needed
                      //     Text('${event.teams.length}'),
                      //   ],
                      // ),
                      Text(
                        'Groups : ${event.teams.length}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
