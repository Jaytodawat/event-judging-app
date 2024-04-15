import 'package:judge_assist_app/features/domain/entities/Event.dart';

class Team {
  late int id;
  late String name;
  // late String leaderName;
  late String leaderEmail;
  late Map<String, int> marks;
  late int eventId;

  Team(this.name, this.leaderEmail,
      this.eventId);

  Team.name(this.id, this.name,  this.leaderEmail);
}