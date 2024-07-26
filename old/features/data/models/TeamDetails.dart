class TeamDetails{
  int teamId;
  String teamName;
  String teamEmail;
  String eventName;
  String judgeName;
  Map<int, int> scores;

  TeamDetails({
    required this.teamId,
    required this.teamName,
    required this.teamEmail,
    required this.eventName,
    required this.judgeName,
    required this.scores,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> scoresList = json['scores'];
    Map<int, int> scoresMap = {};
    scoresList.forEach((score) {
      scoresMap[score['param_id']] = score['score'];
    });

    return TeamDetails(
      teamId: json['team_id'],
      teamName: json['team_name'],
      teamEmail: json['team_email'],
      eventName: json['event_name'],
      judgeName: json['judge_name'],
      scores: scoresMap,
    );
  }
}