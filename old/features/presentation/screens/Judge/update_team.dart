import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/data/models/TeamScore.dart';
import 'package:judge_assist_app/features/presentation/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/widgets/reusable_textfields.dart';

class UpdateTeamScreen extends StatelessWidget {
  final Event event;
  final Team team;
  final int judgeId;
  UpdateTeamScreen(
      {super.key,
      required this.event,
      required this.team,
      required this.judgeId});

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController idController = TextEditingController();
  late final List<String> parameters;

  TeamScore _addTeam(Team team, List<CustomTextField> inputList) {
    Map<String, int> parameterMap = event.parameterId;
    Map<int?, int> scoreMap = {};
    for (int i = 0; i < inputList.length; i++) {
      CustomTextField customTextField = inputList[i];
      String parameter = parameters[i];
      int score = int.parse(customTextField.controller.text);
      scoreMap[parameterMap[parameter]] = score;
    }
    TeamScore teamScore = TeamScore(event.id, team.id, judgeId, scoreMap);
    return teamScore;
  }

  @override
  Widget build(BuildContext context) {
    parameters = event.parameterList;
    List<CustomTextField> inputList = [];
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Add Score',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Team Id : ${team.id}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Team Name : ${team.name}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Parameters : ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: parameters.length,
                    itemBuilder: (context, index) {
                      String parameter = parameters[index];
                      CustomTextField customTextField =
                          CustomTextField(parameter: parameter, team: team);
                      inputList.add(customTextField);
                      return customTextField;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: RoundedButton(
          text: "Submit",
          onPressed: () {
            try {
              TeamScore teamScore = _addTeam(team, inputList);
              Provider.of<EventListModel>(context, listen: false)
                  .addScore(teamScore);
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to update score!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
