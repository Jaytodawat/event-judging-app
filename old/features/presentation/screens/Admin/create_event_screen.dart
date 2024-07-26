import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';
import 'package:provider/provider.dart';
import 'package:judge_assist_app/constants.dart';
import '../../providers/event_provider.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController parametersController = TextEditingController();

  TextEditingController startingDate = TextEditingController();

  TextEditingController endingDate = TextEditingController();

  String? selectedResultType;
  List<String> list = <String>['AVG', 'MIN', 'MAX'];

  @override
  void initState() {
    super.initState();
    selectedResultType = list[0];
  }


  DateTime selectedDate = DateTime.now();
  // Map<String, int
  List<String> parameterList = [];
  Map<String, int> parameterMarks = {};
  Event _addEvent() {
    // print(parameterList);
    String name = nameController.text.trim();
    DateTime startDate = DateTime.parse(startingDate.text.trim());
    DateTime endDate = DateTime.parse(endingDate.text.trim());
    for (int i = 0; i < parameterList.length; i++) {
      parameterList[i] = parameterList[i].trim();
    }
    Event event = Event.name(name, startDate, endDate, parameterList, parameterMarks, selectedResultType!);
    return event;
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     startingDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: kTitle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: sh * 0.75,
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
                      ),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate) {
                        selectedDate = picked;
                        startingDate.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
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
                      ),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate) {
                        selectedDate = picked;
                        endingDate.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: sw * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xFF1D1D2F),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pending_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: "Result Criteria",

                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: selectedResultType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedResultType = newValue;
                      });
                    },
                    items: list.map((String type) {
                      return DropdownMenuItem<String>(

                        value: type,
                        child: Text(type, style: const TextStyle(color: Colors.white),),
                      );
                    }).toList(),
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
                    controller: marksController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.pending_outlined,
                        color: Colors.white,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {

                              setState(() {
                                if(parametersController.text.trim() != '' && marksController.text.trim() != ''){
                                  try{
                                    String parameter = parametersController.text.trim();
                                    int marks = int.parse(marksController.text.trim());
                                    parameterMarks[parameter] = marks;
                                    parameterList.add(parameter);
                                  } catch (e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter valid value"),
                                        backgroundColor: Colors.red, // Customize as needed
                                      ),
                                    );
                                  }

                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Enter Maximum marks and Parameter Name"),
                                      backgroundColor: Colors.red, // Customize as needed
                                    ),
                                  );
                                }
                                parametersController.clear();
                                marksController.clear();

                              });
                            },
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.zero,
                      label: const Text(
                        "Maximum Marks",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: parameterList.map((string) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Chip(
                          label: Text('$string(${parameterMarks[string]})'),
                          onDeleted: () {
                            setState(() {
                              parameterList.remove(string);
                              parameterMarks.remove(string);
                            });
                          },
                        ),
                      );
                    }).toList(),
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
                      try{
                      Event event = _addEvent();
                      Provider.of<EventListModel>(context, listen: false)
                          .addEvent(event); // Add event to the database
                      Navigator.pop(context);
                      } catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to create event!'),
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
    ),);
  }
}
