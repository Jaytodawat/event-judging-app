import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_list_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool flag = false;
  FlipCardController _flipCardController = FlipCardController();
  Color a(bool flag) {
    if (flag == false) {
      return Colors.pink;
    }
    return const Color(0xFF1D1D2F);
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log In",
          style: kTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: sh * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (flag) {
                        _flipCardController.toggleCard();
                      }
                      flag = false;
                    });
                  },
                  child: Container(
                    height: sh * 0.04,
                    width: sw * 0.3,
                    decoration: BoxDecoration(
                        color: a(flag),
                        borderRadius: BorderRadius.circular(0.0)),
                    child: const Center(
                      child: Text(
                        "Admin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!flag) {
                        _flipCardController.toggleCard();
                      }
                      flag = true;
                    });
                  },
                  child: Container(
                    height: sh * 0.04,
                    width: sw * 0.3,
                    decoration: BoxDecoration(
                        color: a(!flag),
                        borderRadius: BorderRadius.circular(0.0)),
                    child: const Center(
                      child: Text(
                        "Judge",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sh * 0.05,
            ),
            FlipCard(
                flipOnTouch: false,
                controller: _flipCardController,
                front: Admin(),
                back: Judge())
          ],
        ),
      ),
    );
  }
}

class Admin extends StatelessWidget {
  Admin({super.key});
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Container(
      height: sh * 0.5,
      width: sw * 0.9,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFF0F0F1F).withOpacity(0.7),
            const Color(0xFF1D1D2F),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20.0)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   width: sw * 0.6,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(color: Colors.white),
          //     decoration: InputDecoration(
          //         prefixIcon: const Icon(
          //           CupertinoIcons.profile_circled,
          //           color: Colors.white,
          //         ),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.0)),
          //         contentPadding: EdgeInsets.zero,
          //         label: const Text(
          //           "Admin Name",
          //           style: TextStyle(color: Colors.white),
          //         )),
          //   ),
          // ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              controller: userName,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.alternate_email,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Admin UserName",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Admin Password",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.4,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
              onPressed: () {

                String user = userName.text;
                String pass = password.text;
                if(user == 'admin' && pass == 'admin123'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminEventListScreen(),
                    ),
                  );
                } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incorrect Credential'),
                        backgroundColor: Colors.red, // Customize as needed
                      ),
                    );
                }

              },
              child: Text(
                "Submit",
                style: kButtonStyle,
              ),
            ),
          )
        ],
      )),
    );
  }
}

class Judge extends StatelessWidget {
  Judge({super.key});
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Container(
      height: sh * 0.5,
      width: sw * 0.9,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFF0F0F1F).withOpacity(0.7),
            const Color(0xFF1D1D2F),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20.0)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: sw * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: idController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                contentPadding: EdgeInsets.zero,
                label: const Text(
                  "Judge Id",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              controller: userName,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.alternate_email,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Judge Email",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Judge Password",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.4,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(20.0)),
            child: TextButton(
              onPressed: () async {
                // Provider.of<EventListModel>(context, listen: false)
                //     .clearEvents();
                // Provider.of<EventListModel>(context, listen: false)
                //     .getEvents();
                // int id = int.parse(idController.text);
                // // idController.dispose();
                // // userName.dispose();
                // // password.dispose();
                //
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HomeScreen(judgeId : id),
                //   ),
                // );


                String check = await Provider.of<EventListModel>(context, listen: false).loginJudge(userName.text, password.text);
                if(check == 'Login successful'){
                  if(context.mounted){
                    // Provider.of<EventListModel>(context, listen: false)
                    //     .clearEvents();
                    // Provider.of<EventListModel>(context, listen: false)
                    //     .getAllEvents();
                    int id = int.parse(idController.text);
                    idController.dispose();
                    userName.dispose();
                    password.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JudgeEventScreen(judgeId: id,),
                      ),
                    );
                  }

                } else {
                  if(context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(check),
                        backgroundColor: Colors.red, // Customize as needed
                      ),
                    );
                  }
                }
              },
              child: Text(
                "Submit",
                style: kButtonStyle,
              ),
            ),
          )
        ],
      )),
    );
  }
}
