class Winner{
  int teamId;
  int eventId;
  String teamName;
  String eventName;
  int teamScore;

  Winner(
      this.teamId, this.eventId, this.teamName, this.eventName, this.teamScore);


  // factory Winner.fromJson(Map<String, dynamic> json) {
  //   return Winner(
  //     json['team_id'],
  //     json['event_id'],
  //     json['team_name'],
  //     json['event_name'],
  //     json['scores']
  //   );
  // }

  factory Winner.fromJson(Map<String, dynamic> json) {
    String averageScoreString = json['average_score'];
    double averageScoreDouble = double.parse(averageScoreString);
    int score = averageScoreDouble.toInt();
    return Winner(
      json['team_id'] as int,
      json['event_id'] as int,
      json['team_name'] as String,
      json['event_name'] as String,
      score,
    );
  }

  static int _parseScore(dynamic score) {
    if (score is int) {
      return score;
    } else {
      return int.tryParse(score) ?? 0; // Default value if parsing fails
    }
    return 0; // Default value if score is not int or String
  }
  // factory Winner.fromJson(Map<String, dynamic> json) {
  //   return Winner(
  //     json['team_id'] as int,
  //     json['event_id'] as int,
  //     json['team_name'] as String,
  //     json['event_name'] as String,
  //     int.parse(json['scores'] as String), // Parsing string to int
  //   );
  // }
}