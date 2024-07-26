import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/data/datasource/api_service.dart';
import 'package:judge_assist_app/features/data/models/TeamDetails.dart';
import 'package:judge_assist_app/features/data/models/TeamModel.dart';
import 'package:judge_assist_app/features/data/models/TeamScore.dart';
import 'package:judge_assist_app/features/data/models/Winner.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';

import '../../data/models/EventModel.dart';
import '../../data/models/Judge.dart';

class EventListModel extends ChangeNotifier{

  final ApiService apiService;

  // List<Event> _events = [];

  EventListModel({required this.apiService}){
    // print("EventListModel");
  }



  // List<Event> get events => _events;

  void refreshList(){
    notifyListeners();
  }
  Future<void> refresh()async{
    refreshList();
  }

  // Future<List<Event>> getEvents() async{
  //   final eventModels = await apiService.getEvents();
  //   _events = eventModels.map((model)=>model.toEntity()).toList();
  //   refreshList();
  //   return _events;
  // }


  Future<List<Event>> getAllEvents() async{
    final eventModels = await apiService.getEvents();
    List<Event> eventList = eventModels.map((model)=>model.toEntity()).toList();

    return eventList;
  }

  Future<List<Event>> getJudgeEvents(int judgeId) async {
    final eventModels = await apiService.getJudgeEvents(judgeId);
    List<Event> eventList = eventModels.map((model)=>model.toEntity()).toList();
    return eventList;
  }

  void addEvent(Event event) async{
    EventModel eventModel = EventModel.fromEntity(event);
    await apiService.addEvent(eventModel);
    refreshList();
  }

  Future<List<Team>> getTeams(List<int> teamIds) async{
    List<Team> teamList = [];
    for(int i = 0; i < teamIds.length; i++){
      int id = teamIds[i];
      TeamModel teamModel = await apiService.getTeam(id);
      Team team = teamModel.toEntity();
      teamList.add(team);
    }
    return teamList;
  }

  Future<Team> addTeam(Team team) async {
    TeamModel teamModel = TeamModel.fromEntity(team);
    int id = await apiService.addTeam(teamModel);
    team.id = id;
    refreshList();
    return team;

  }



  Future<List<Winner>> getWinnerList(int eventId) async{
    List<Winner> winnerList = await apiService.getWinnerList(eventId);
    return winnerList;
  }

  Future<Judge> addJudge(Judge judge) async{
    Judge addedJudge = await apiService.addJudge(judge);
    return addedJudge;
  }


  Future<String> loginJudge(String email, String password) async{
    Judge judge = Judge.login(email, password);
    String check = await apiService.loginJudge(judge);
    return check;
  }

  Future<String> loginAdmin(String email, String password) async{
    String check = await apiService.loginAdmin(email, password);
    return check;
  }

  Future<TeamDetails> getTeamScore(int teamId) async{
    TeamDetails teamDetails = await apiService.getTeamScores(teamId);
    return teamDetails;
  }

  void addScore(TeamScore teamScore){
    apiService.addTeamScore(teamScore);
    refreshList();
  }



  // void clearEvents(){
  //   _events.clear();
  //   refreshList();
  // }






}


