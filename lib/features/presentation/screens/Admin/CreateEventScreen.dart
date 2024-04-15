import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_list_screen.dart';
import 'package:judge_assist_app/features/presentation/widgets/custom_buttons.dart';
import 'package:judge_assist_app/features/presentation/widgets/reusable_textfields.dart';
import 'package:provider/provider.dart';
import 'package:judge_assist_app/constants.dart';
import '../../providers/event_provider.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController parametersController = TextEditingController();
  TextEditingController startingDate = TextEditingController();
  TextEditingController endingDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Event _addEvent(){
    String name = nameController.text;
    String parameters = parametersController.text;
    DateTime startDate = DateTime.parse(startingDate.text);
    DateTime endDate = DateTime.parse(endingDate.text);
    List<String> parameterList = parameters.split(",");
    for(int i = 0; i < parameterList.length; i++){
      parameterList[i] = parameterList[i].trim();
    }
    Event event = Event.name(name, startDate, endDate, parameterList);
    return event;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      startingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Create Event",
          style: kTitle,),
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
                          "Event Name",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
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
                    controller: parametersController,
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
                          "Parameters",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
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
                    controller: startingDate,
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
                        "Starting Date",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate) {
                        selectedDate = picked;
                        startingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
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
                    controller: endingDate,
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
                        "Ending Date",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate) {
                        selectedDate = picked;
                        endingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
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
                      Event event = _addEvent();
                      Provider.of<EventListModel>(context, listen: false).addEvent(event); // Add event to the database
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventListScreen(),
                        ),
                      ); // Go back to the previous screen
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









// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:judge_assist_app/features/domain/entities/Event.dart';
// import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_list_screen.dart';
// import 'package:judge_assist_app/features/presentation/widgets/custom_buttons.dart';
// import 'package:judge_assist_app/features/presentation/widgets/reusable_textfields.dart';
// import 'package:provider/provider.dart';
// import 'package:judge_assist_app/constants.dart';
// import '../../providers/event_provider.dart';
//
// class CreateEventScreen extends StatelessWidget {
//   CreateEventScreen({super.key});
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController parametersController = TextEditingController();
//   TextEditingController startingDate = TextEditingController();
//   TextEditingController endingDate = TextEditingController();
//
//   DateTime selectedDate = DateTime.now();
//
//   Event _addEvent(){
//     String name = nameController.text;
//     String parameters = parametersController.text;
//     DateTime startDate = DateTime.parse(startingDate.text);
//     DateTime endDate = DateTime.parse(endingDate.text);
//     List<String> parameterList = parameters.split(",");
//     for(int i = 0; i < parameterList.length; i++){
//       parameterList[i] = parameterList[i].trim();
//     }
//     Event event = Event.name(name, startDate, endDate, parameterList);
//     return event;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       selectedDate = picked;
//       startingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double sh = MediaQuery.of(context).size.height;
//     double sw = MediaQuery.of(context).size.width;
//     final List<Event> eventList = Provider.of<EventListModel>(context).events;
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         // leading: ,
//         title: Text("Create Event",
//         style: kTitle,),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             height: sh * 0.5,
//             width: sw * 0.9,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.0),
//                 color: const Color(0xFF1D1D2F)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                 // Container(
//                 //   width: sw * 0.6,
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(20.0),
//                 //   ),
//                 //   child: TextField(
//                 //     controller: idController,
//                 //     style: const TextStyle(color: Colors.white),
//                 //     decoration: InputDecoration(
//                 //         prefixIcon: const Icon(
//                 //           Icons.pending_outlined,
//                 //           color: Colors.white,
//                 //         ),
//                 //         border: OutlineInputBorder(
//                 //             borderRadius: BorderRadius.circular(10.0)),
//                 //         contentPadding: EdgeInsets.zero,
//                 //         label: const Text(
//                 //           "Event Id",
//                 //           style: TextStyle(
//                 //               color: Colors.white, fontWeight: FontWeight.bold),
//                 //         )),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 5,
//                 // ),
//                 Container(
//                   width: sw * 0.6,
//                   decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//                   child: TextField(
//                     controller: nameController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                         prefixIcon: const Icon(
//                           Icons.pending_outlined,
//                           color: Colors.white,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         contentPadding: EdgeInsets.zero,
//                         label: const Text(
//                           "Event Name",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   width: sw * 0.6,
//                   decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//                   child: TextField(
//                     controller: parametersController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                         prefixIcon: const Icon(
//                           Icons.pending_outlined,
//                           color: Colors.white,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         contentPadding: EdgeInsets.zero,
//                         label: const Text(
//                           "Parameters",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   width: sw * 0.6,
//                   decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//                   child: TextField(
//                     controller: startingDate,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                         prefixIcon: const Icon(
//                           Icons.pending_outlined,
//                           color: Colors.white,
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0)),
//                         contentPadding: EdgeInsets.zero,
//                         label: const Text(
//                           "Starting Date",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),),
//                     onTap: () async {
//                       final DateTime? picked = await showDatePicker(
//                         context: context,
//                         initialDate: selectedDate,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null && picked != selectedDate) {
//                         selectedDate = picked;
//                         startingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   width: sw * 0.6,
//                   decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
//                   child: TextField(
//                     controller: endingDate,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.pending_outlined,
//                         color: Colors.white,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0)),
//                       contentPadding: EdgeInsets.zero,
//                       label: const Text(
//                         "Ending Date",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),),
//                     onTap: () async {
//                       final DateTime? picked = await showDatePicker(
//                         context: context,
//                         initialDate: selectedDate,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null && picked != selectedDate) {
//                         selectedDate = picked;
//                         endingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//                       }
//
//
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   height: sh * 0.05,
//                   width: sw * 0.3,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     color: Colors.pink,
//                   ),
//                   child: TextButton(
//                     onPressed: () {
//                       Event event = _addEvent();
//                       Provider.of<EventListModel>(context, listen: false).addEvent(event);
//                       Provider.of<EventListModel>(context, listen: false).getEvents();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EventListScreen(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Add",
//                       style: kButtonStyle,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }