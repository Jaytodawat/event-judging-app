import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/AdminHomeScreen.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_list_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/home_screen.dart';

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
                front: const admin(),
                back: const judge())
          ],
        ),
      ),
    );
  }
}

class admin extends StatelessWidget {
  const admin({super.key});

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
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Admin Name",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
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
                    "Admin Email",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen(),
                  ),
                );
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

class judge extends StatelessWidget {
  const judge({super.key});

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
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  label: const Text(
                    "Judge Name",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
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
