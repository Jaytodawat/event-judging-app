import 'package:flutter/material.dart';

import '../../../domain/entities/Team.dart';

class TeamDetailScreen extends StatelessWidget {
  final Team team;
  const TeamDetailScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(team.name, style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(child: Center(child: Text('Team Details will be shown here...', style: TextStyle(color: Colors.white),),),),
    ));
  }
}
