import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/data/models/TeamDetails.dart';
import 'package:provider/provider.dart';

import '../../providers/event_provider.dart';

class TeamDetailsScreen extends StatelessWidget {
  final int teamId;
  final Map<String, int> parameters;
  const TeamDetailsScreen({super.key, required this.teamId, required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details', style: TextStyle(color:  Colors.white),),
      ),
      body: Consumer<EventListModel>(
        builder: (context, eventListModel, child) {
          return FutureBuilder<TeamDetails>(
            future: eventListModel.getTeamScore(teamId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Team Not Judged yet', style : TextStyle(fontSize: 16, color:  Colors.white),),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data available', style : TextStyle(fontSize: 16, color:  Colors.white),),
                );
              } else {
                return _buildTeamDetails(snapshot.data!);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildTeamDetails(TeamDetails teamDetails) {
    Map<String, int> scores = {};
    for(var key in parameters.keys){
      String p = key;
      int? id = parameters[key];
      int? score = teamDetails.scores[id];
      scores[p] = score!;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team ID: ${teamDetails.teamId}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Team Name: ${teamDetails.teamName}',
            style: const TextStyle(fontSize: 16, color:  Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Team Email: ${teamDetails.teamEmail}',
            style: const TextStyle(fontSize: 16, color:  Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Event Name: ${teamDetails.eventName}',
            style: const TextStyle(fontSize: 16, color:  Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Judge Name: ${teamDetails.judgeName}',
            style: const TextStyle(fontSize: 16, color:  Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Scores:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: scores.entries.map((entry) {
              return Text(
                '${entry.key} : ${entry.value}',
                style: const TextStyle(fontSize: 16, color:  Colors.white),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
