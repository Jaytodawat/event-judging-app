import 'package:judge_assist_app/features/domain/entities/Event.dart';

class EventModel {
  late int id;
  late String name;
  late DateTime startDate;
  late DateTime endDate;
  late List<String> parameterList;
  late Map<String, int> parameterId;
  late List<int> teamId;
  late Map<String, int> parameterMarks;
  late String resultType;

  EventModel(this.id, this.name, this.startDate, this.endDate,
      this.parameterList, this.parameterId, this.teamId);
  EventModel.judge(this.id, this.name, this.startDate, this.endDate,
      this.parameterList, this.parameterId, this.teamId);

  EventModel.name(this.name, this.startDate, this.endDate, this.parameterList, this.parameterMarks, this.resultType);

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> formattedParameters = parameterList.map((param) {
      return {
        'name': param,
        'marks': parameterMarks[param],
      };
    }).toList();
    return {
      'name': name,
      'starting_date': startDate.toIso8601String(),
      'ending_date': endDate.toIso8601String(),
      'parameters': formattedParameters
    };
  }



  factory EventModel.fromJudgeJson(Map<String, dynamic> json, List<dynamic> users) {
    // Extract event data
    print(json);
    print(users);
    // Map<String, dynamic> eventData = json['event'];
    int eventId = json['pk_eventid'];
    String eventName = json['name'];

    // Extract team IDs from users
    List<int> teamIds = [];
    for(var team in users){
      teamIds.add(team["pk_id"]);
    }
    print(teamIds);

    // Extract parameter names
    List<String> parameterNames = (json['params'] as List)
        .map((param) => param['param_name'] as String)
        .toList();
    Map<String, int> map = {};
    for (var parameter in json['params']) {
      map[parameter['param_name']] = parameter['param_id'];
    }
    // Parse dates if necessary
    DateTime startDate = DateTime.parse(json['starting_date']);
    DateTime endDate = DateTime.parse(json['ending_date']);
    // DateTime createdDate = DateTime.parse(eventData['created_at']);

    return EventModel.judge(
      eventId,
      eventName,
      startDate,
      endDate,
      parameterNames,
      map,
      teamIds,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Extract event data
    Map<String, dynamic> eventData = json['event'];
    int eventId = eventData['pk_eventid'];
    String eventName = eventData['name'];

    // Extract team IDs from users
    List<int> teamIds =
        (json['users'] as List).map((user) => user['pk_id'] as int).toList();

    // Extract parameter names
    List<String> parameterNames = (json['parameters'] as List)
        .map((param) => param['name'] as String)
        .toList();
    Map<String, int> map = {};
    for (var parameter in json['parameters']) {
      map[parameter['name']] = parameter['pk_paramid'];
    }
    // Parse dates if necessary
    DateTime startDate = DateTime.parse(eventData['starting_date']);
    DateTime endDate = DateTime.parse(eventData['ending_date']);
    DateTime createdDate = DateTime.parse(eventData['created_at']);

    return EventModel(
      eventId,
      eventName,
      startDate,
      endDate,
      parameterNames,
      map,
      teamIds,
    );
  }

  Event toEntity() => Event(id, name, startDate, endDate,
      parameterList, parameterId, teamId);

  factory EventModel.fromEntity(Event event) => EventModel.name(
      event.name, event.startDate, event.endDate, event.parameterList, event.parameterMarks, event.resultType);
}
