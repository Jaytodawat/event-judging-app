import 'package:judge_assist_app/features/domain/entities/Team.dart';

class Event{
  int id;
  String name;
  List<String> parameterList;
  List<Team> teams;
  // List<Judge> judges;

  Event(this.id, this.name, this.parameterList, this.teams);
}

