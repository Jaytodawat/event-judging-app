import 'package:judge_assist_app/features/domain/entities/Team.dart';

class Event{
  int id;
  String name;
  List<String> parameterList;
  List<Team> teams;

  Event(this.id, this.name, this.parameterList, this.teams);
}

