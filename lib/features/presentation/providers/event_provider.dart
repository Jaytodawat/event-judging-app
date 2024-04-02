

import 'package:flutter/material.dart';
import 'package:judge_assist_app/features/domain/entities/Event.dart';

class EventListModel extends ChangeNotifier{
  List<Event> _events = [];
  EventListModel(){
    List<Event> eventList = [];

    Event e1 = Event(1, "Credenz", ["Presentation", "Code", "Team Performance", "Functionality"], []);
    Event e2 = Event(2, "Pradnya", ["Code Quality", "Efficiency", "Team Performance", "Correctness"], []);
    Event e3 = Event(3, "Xenia", ["Presentation", "Code", "Team Performance"], []);
    Event e4 = Event(4, "INC", ["Presentation", "Innovation", "Team Performance", "Impact"], []);
    eventList.add(e1);
    eventList.add(e2);
    eventList.add(e3);
    eventList.add(e4);
    _events = eventList;
  }


  List<Event> get events => _events;

  void refreshList(){
    notifyListeners();
  }
}