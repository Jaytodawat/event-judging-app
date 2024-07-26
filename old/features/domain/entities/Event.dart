import 'package:judge_assist_app/features/data/models/EventModel.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';

class Event{
  late int id;
  late String name;
  late DateTime startDate;
  late DateTime endDate;
  late List<String> parameterList;
  late Map<String, int> parameterId;
  late List<int> teams;
  late Map<String, int> parameterMarks;
  late String resultType;

  Event(this.id, this.name, this.startDate, this.endDate,
      this.parameterList, this.parameterId, this.teams);

  Event.name(this.name, this.startDate, this.endDate,  this.parameterList, this.parameterMarks, this.resultType);
}

