import 'package:flutter/material.dart';
import 'package:judge_assist_app/constants.dart';
import 'package:judge_assist_app/features/presentation/screens/event_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/home_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Screen",
          style: TextStyle(
            // color: Color(0xFFff0049)
            color: Colors.white
          ),
          ),
          centerTitle: true,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){}, child: Text("Register Event",style: kButtonStyle,)),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }, child: Text("View All Events",style: kButtonStyle,),)
          ],
        ),
      ),
    );
  }
}
