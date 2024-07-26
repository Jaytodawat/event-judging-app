import '../../domain/entities/Team.dart';

class TeamModel {
  int id;
  String name;
  late String leaderName;
  String leaderEmail;
  late int eventId;
  TeamModel(
      this.id, this.name,  this.leaderEmail, this.eventId);
  TeamModel.name(this.id, this.name,  this.leaderEmail, this.eventId);

  TeamModel.name1(this.id, this.name,  this.leaderEmail);

  Map<String, dynamic> toJson() {
    return {'email': leaderEmail, 'name': name, 'event_id': eventId};
  }

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel.name1(
        json["pk_teamid"], json["name"],  json["email"]);
  }

  Team toEntity() => Team.name(id, name, leaderEmail);

  factory TeamModel.fromEntity(Team team) =>
      TeamModel.name(0, team.name,  team.leaderEmail, team.eventId);
}
