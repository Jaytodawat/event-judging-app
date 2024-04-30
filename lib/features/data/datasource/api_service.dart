import 'package:dio/dio.dart';
import 'package:judge_assist_app/features/data/models/Judge.dart';
import 'package:judge_assist_app/features/data/models/TeamModel.dart';
import 'package:judge_assist_app/features/data/models/TeamScore.dart';
import 'package:judge_assist_app/features/data/models/Winner.dart';

import '../models/EventModel.dart';
import '../models/TeamDetails.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<EventModel>> getEvents() async {
    // print("ApiService1");
    try {
      final response =
          await dio.get('https://judging-be-p1j9.onrender.com/dev/api/admin/events');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['response'];
        
        return responseData
            .map((eventJson) => EventModel.fromJson(eventJson))
            .toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      // print(e.toString());
      throw Exception('Failed to load events: $e');
    }
  }

  Future<List<EventModel>> getJudgeEvents(int judgeId) async {
    // print("ApiService1");
    try {
      final response = await dio.get('https://judging-be-p1j9.onrender.com/dev/api/judge/events/$judgeId');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = response.data[0];
        // print(responseData[0]);
        int id = responseData["pk_eventid"];
        // int id = int.parse(sid);
        // print(id);
        final eventResponse = await dio.get('https://judging-be-p1j9.onrender.com/dev/api/admin/events/$id');
        final dynamic eventData = eventResponse.data['data'][0];
        final List<dynamic> teamData = eventResponse.data['users'];
        // print(teamData);
        EventModel eventModel = EventModel.fromJudgeJson(eventData, teamData);
        List<EventModel> eventList = [];
        eventList.add(eventModel);
        return eventList;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Failed to load events data: $e');
    }
  }

  Future<List<Winner>> getWinnerList(int eventId) async {
    // print("ApiService1");
    try {
      final response =
      await dio.get('https://judging-be-p1j9.onrender.com/dev/api/admin//winner/$eventId');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        // print(responseData);
        return responseData.map((json) => Winner.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load winner list');
      }
    } catch (e) {
      throw Exception('Failed to load winner list: $e');
    }
  }

  void addTeamScore(TeamScore teamScore){
    Map<String, dynamic> json = teamScore.toJson();
    // print(json);
    try{
      dio.post('https://judging-be-p1j9.onrender.com/dev/api/judge/score', data: json);
    } catch(e){
      throw Exception('Failed to update score: $e');
    }
  }

  Future<int> getEventById(int id) async {
    // print("ApiService1");
    try {
      final response = await dio.get('https://judging-be-p1j9.onrender.com/dev/api/admin/events/$id');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = response.data[0];
        return int.parse(responseData["pk_eventid"]);
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }



  Future<void> addEvent(EventModel eventModel) async {
    Map<String, dynamic> eventBody = eventModel.toJson();
    // print(eventBody);
    // print("ApiService2");
    try {
      final response = await dio.post(
          'https://judging-be-p1j9.onrender.com/dev/api/admin/events',
          data: eventBody);
      // print(response.statusCode);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return;
      } else {
        throw Exception('Failed to add event');
      }
    } catch (e) {
      throw Exception('Failed to add event: $e');
    }
  }

  Future<TeamModel> getTeam(int teamId) async {
    try {
      final response = await dio
          .get('https://judging-be-p1j9.onrender.com/dev/api/admin/team/$teamId');
      final Map<String, dynamic> responseData = response.data[0];
      if (response.statusCode == 200) {
        return TeamModel.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch team');
      }
    } catch (e) {
      throw Exception('Failed to fetch team: $e');
    }
  }

  Future<int> addTeam(TeamModel teamModel) async {
    Map<String, dynamic> teamData = teamModel.toJson();
    try {
      final response = await dio.post(
          'https://judging-be-p1j9.onrender.com/dev/api/admin/team',
          data: teamData);

      if (response.statusCode == 201) {
        int teamId = response.data["pk_teamid"];
        // teamScore.teamId = teamId;
        // addTeamScore(teamScore);
        return teamId;
      } else {
        throw Exception('Failed to add team');
      }
    } catch (e) {
      // print(e.toString());
      throw Exception('Failed to add team: ');
    }
  }



  Future<Judge> addJudge(Judge judge) async {
    Map<String, dynamic> judgeData = judge.toJson();
    // print(judgeData);
    try {
      final response = await dio.post(
          'https://judging-be-p1j9.onrender.com/dev/api/admin/judge',
          data: judgeData);
      // print(response.data);
      if (response.statusCode == 201) {
        Judge createdJudge = Judge.fromJson(response.data);
        return createdJudge;
      } else {
        throw Exception('Failed to add team');
      }
    } catch (e) {
      throw Exception('Failed to add team: $e');
    }
  }

  Future<String> loginAdmin(String email, String password) async {
    Map<String, dynamic> judgeData = {
      "email": email,
      "password": password
    };
    try {
      final response = await dio.post(
        'https://judging-be-p1j9.onrender.com/dev/api/admin/login',
        data: judgeData,
      );
      // print(response.statusCode);
      if (response.statusCode! >= 400) {
        return 'Invalid credentials';
      } else if (response.statusCode == 200) {
        return 'Login successful';
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return 'Failed to login'; // Return generic error message
    }
  }

  Future<String> loginJudge(Judge judge) async {
    Map<String, dynamic> judgeData = judge.toLoginJson();
    try {
      final response = await dio.post(
        'https://judging-be-p1j9.onrender.com/dev/api/judge/login',
        data: judgeData,
      );
      // print(response.statusCode);
      if (response.statusCode! >= 400) {
        return 'Invalid credentials';
      } else if (response.statusCode == 200) {
        return 'Login successful';
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {

      return 'Failed to login'; // Return generic error message
    }
  }



  Future<TeamDetails> getTeamScores(int teamId) async{

    try{
      final response = await dio.get(
          'https://judging-be-p1j9.onrender.com/dev/api/admin/team/score/$teamId');

      if(response.statusCode == 200){
        final Map<String, dynamic> responseData = response.data[0];

        // print(responseData);
        return TeamDetails.fromJson(responseData);
      } else {
        throw Exception('Failed to get team score');
      }
    }catch(e){
      throw Exception('Failed to get team score: $e');
    }
  }


// Future<int> addTeam(TeamModel teamModel, TeamScore teamScore) async {
//   Map<String, dynamic> teamData = teamModel.toJson();
//   try {
//     final response = await dio.post(
//         'https://judging-be.onrender.com/dev/api/admin/team',
//         data: teamData);
//
//     if (response.statusCode == 200) {
//       int teamId = response.data["pk_teamid"];
//       teamScore.teamId = teamId;
//       // addTeamScore(teamScore);
//       return teamId;
//     } else {
//       throw Exception('Failed to add team');
//     }
//   } catch (e) {
//     print(e.toString());
//     throw Exception('Failed to add team: ');
//   }
// }



}
