import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';
import 'package:judge_assist_app/features/presentation/providers/event_provider.dart';
import 'package:judge_assist_app/features/presentation/widgets/reusable_textfields.dart';

class CreateTeamScreen extends StatelessWidget {
  final Event event;
  CreateTeamScreen({super.key, required this.event});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  late final List<String> parameters;

  void _addTeam(Team team, List<CustomTextField> inputList) {
    team.name = nameController.text;
    team.id = int.parse(idController.text);
    int total = 0;
    for (int i = 0; i < inputList.length; i++) {
      CustomTextField customTextField = inputList[i];
      String parameter = parameters[i];
      int score = int.parse(customTextField.controller.text);
      team.marks[parameter] = score;
      total += score;
    }
    team.marks["total"] = total;
    event.teams.add(team);
  }

  @override
  Widget build(BuildContext context) {
    parameters = event.parameterList;
    Team team = Team();
    team.marks = <String, int>{};
    List<CustomTextField> inputList = [];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    color: Colors.black,
                    size: 30,
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Create Team And Judge',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  controller: idController,
                  labelText: 'Team Id',
                  obsecureText: false,
                  icon: const Icon(
                    Icons.numbers,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  controller: nameController,
                  labelText: 'Team Name',
                  obsecureText: false,
                  icon: const Icon(
                    Icons.groups,
                  ),
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
            _addTeam(team, inputList);
            Provider.of<EventListModel>(context, listen: false).refreshList();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
