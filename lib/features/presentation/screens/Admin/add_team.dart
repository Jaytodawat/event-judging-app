import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/domain/entities/Team.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import 'package:judge_assist_app/constants.dart';

class AddTeam extends StatelessWidget {
  final Event event;
  AddTeam({super.key, required this.event});
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController leaderNameController = TextEditingController();
  final TextEditingController leaderEmailController = TextEditingController();

  Team _addTeam() {
    String name = nameController.text;
    // String leaderName = leaderNameController.text;
    String leaderEmail = leaderEmailController.text;
    Team team = Team(name, leaderEmail, event.id);
    return team;
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Team",
          style: kTitle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: sh * 0.5,
            width: sw * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFF1D1D2F)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: sw * 0.6,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pending_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.zero,
                      label: const Text(
                        "Team Name",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: sw * 0.6,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller: leaderNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pending_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.zero,
                      label: const Text(
                        "Leader Name",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: sw * 0.6,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller: leaderEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.pending_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.zero,
                        label: const Text(
                          "Leader Email",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(
                  height: sh * 0.01,
                ),
                Container(
                  height: sh * 0.05,
                  width: sw * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.pink,
                  ),
                  child: TextButton(
                    onPressed: () {
                      try {
                        Team team = _addTeam();
                        Provider.of<EventListModel>(context, listen: false)
                            .addTeam(team);
                        Navigator.pop(context);
                      } catch (e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to add team!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Add",
                      style: kButtonStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
