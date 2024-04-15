class TeamScore{
  int eventId;
  int teamId;
  int judgeId;
  Map<int?, int> scores;

  TeamScore(this.eventId, this.teamId, this.judgeId, this.scores);

  Map<String, dynamic> toJson() {
    List<Map<String, int>> scoresList = scores.entries
        .map((entry) => {'param_id': entry.key!, 'marks': entry.value})
        .toList();

    return {
      'event_id': eventId,
      'team_id': teamId,
      'judge_id': judgeId,
      'scores': scoresList,
    };
  }

}