import 'package:judge_assist_app/features/data/models/EventModel.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';

class Event{
  late int id;
  late String name;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime createdDate;
  late List<String> parameterList;
  late Map<String, int> parameterId;
  late List<int> teams;

  Event(this.id, this.name, this.startDate, this.endDate, this.createdDate,
      this.parameterList, this.parameterId, this.teams);

  Event.name(this.name, this.startDate, this.endDate,  this.parameterList);
}

