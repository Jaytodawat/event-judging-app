import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';

import '../../domain/entities/Team.dart';
import '../../../constants.dart';

class TeamCard extends StatelessWidget {
  final int index;
  final Team team;
  const TeamCard({super.key, required this.index, required this.team});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                        '${team.id}',
                        style: kSubTextStyle.copyWith(
                            color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        team.name,
                        style: kSubTextStyle1.copyWith(fontSize: 14),
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(Icons.score),
                      //     const SizedBox(width: 8), // Adjust the spacing between the icon and text as needed
                      //     Text('${team.marks["total"]}'),
                      //   ],
                      // ),
                      Text(
                        'Score : ${team.marks["total"]}',
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
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => StationDetailScreen(
        //       station: station,
        //       stationIndex: index,
        //     ),
        //   ),
        // );
      },
    );
  }
}
