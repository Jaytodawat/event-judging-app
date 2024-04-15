import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/CreateEventScreen.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_teams_screen.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Event.dart';
import '../../../domain/entities/Team.dart';
import '../../providers/event_provider.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/event_card.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late List<Event> eventList = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() async {
        eventList = await Provider.of<EventListModel>(context, listen: false).getEvents();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Events',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<EventListModel>(
            builder: (context, eventListModel, _) {
              if (eventList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    Event event = eventList[index];
                    return EventCard(
                      event: event,
                      onTap: () async{
                        List<Team> teamList = await Provider.of<EventListModel>(context, listen: false).getTeams(event.teams);
                        if (context.mounted){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventTeamScreen(
                                event: event, teams: teamList,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        bottomNavigationBar: RoundedButton(
          text: "Create Event",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEventScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:judge_assist_app/features/presentation/screens/Admin/CreateEventScreen.dart';
// import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_teams_screen.dart';
// import 'package:judge_assist_app/features/presentation/screens/LoadingScreen.dart';
// import 'package:provider/provider.dart';
//
// import '../../../domain/entities/Event.dart';
// import '../../../domain/entities/Team.dart';
// import '../../providers/event_provider.dart';
// import '../../widgets/custom_buttons.dart';
// import '../../widgets/event_card.dart';
//
// class EventListScreen extends StatefulWidget {
//   const EventListScreen({super.key});
//
//   @override
//   State<EventListScreen> createState() => _EventListScreenState();
// }
//
// class _EventListScreenState extends State<EventListScreen> {
//   late List<Event> eventList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() async {
//         eventList = await Provider.of<EventListModel>(context, listen: false).getEvents();
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(eventList.length);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Events',
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Consumer<EventListModel>(
//             builder: (context, eventListModel, _) => ListView.builder(
//               itemCount: eventList.length,
//               itemBuilder: (context, index) {
//                 Event event = eventList[index];
//                 return EventCard(
//                   event: event,
//                   onTap: () async{
//                     List<Team> teamList = await Provider.of<EventListModel>(context, listen: false).getTeams(event.teams);
//                     if (context.mounted){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EventTeamScreen(
//                             event: event, teams: teamList,
//                           ),
//                         ),
//                       );
//                     }
//
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//         bottomNavigationBar: RoundedButton(
//           text: "Create Event",
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CreateEventScreen(),
//               ),
//             );
//           },
//         ),
//       ),
//
//     );
//   }
// }
