import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_assist_app/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:judge_assist_app/features/presentation/screens/Admin/admin_event_list_screen.dart';
import 'package:judge_assist_app/features/presentation/screens/Judge/judge_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/event_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool flag = false;
  final FlipCardController _flipCardController = FlipCardController();
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
                front: const Admin(),
                back: const Judge())
          ],
        ),
      ),
    );
  }
}

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn().then((loggedIn) {
      if (loggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminEventListScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _saveLoginInfo(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', isAdmin);
    // You can also save other user information if needed
  }

  Future<bool> _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('isAdmin');
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String check = await Provider.of<EventListModel>(context, listen: false)
        .loginAdmin(userName.text.trim(), password.text.trim());

    if (check == 'Login successful') {
      await _saveLoginInfo(true);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminEventListScreen(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(check),
            backgroundColor: Colors.red, // Customize as needed
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Container(
      height: sh * 0.5,
      width: sw * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0F0F1F).withOpacity(0.7),
            const Color(0xFF1D1D2F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                  "User",
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
                  "Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: sw * 0.4,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextButton(
              onPressed: () async{
                await _login();
                // String user = userName.text.trim();
                // String pass = password.text.trim();
                // if (user == "admin" && pass == "admin123") {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const AdminEventListScreen(),
                //     ),
                //   );
                // } else {
                //   if (context.mounted) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text("Wrong Credential"),
                //         backgroundColor: Colors.red, // Customize as needed
                //       ),
                //     );
                //   }
                // }
              },
              child: Text(
                "Submit",
                style: kButtonStyle,
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

class Judge extends StatefulWidget {
  const Judge({super.key});

  @override
  State<Judge> createState() => _JudgeState();
}

class _JudgeState extends State<Judge> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController idController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkJudgeLoggedIn();
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    idController.dispose();
    super.dispose();
  }

  Future<void> _saveJudgeLoginInfo(int judgeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isJudgeLoggedIn', true);
    prefs.setInt('judgeId', judgeId); // Save judge ID
  }

  Future<void> _checkJudgeLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.containsKey('isJudgeLoggedIn');
    if (loggedIn) {
      int judgeId = prefs.getInt('judgeId') ?? 0; // Get judge ID
      if (judgeId != 0) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JudgeEventScreen(judgeId: judgeId),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Container(
      height: sh * 0.5,
      width: sw * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0F0F1F).withOpacity(0.7),
            const Color(0xFF1D1D2F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.zero,
                label: const Text(
                  "Judge Email",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: sw * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.zero,
                label: const Text(
                  "Judge Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: sw * 0.4,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextButton(
              onPressed: () async {
                // int id = int.parse(idController.text.trim());
                // String user = userName.text.trim();
                // String pass = password.text.trim();
                // if (user == "vedant@gmail.com" && pass == "pass123") {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => JudgeEventScreen(
                //         judgeId: 44,
                //       ),
                //     ),
                //   );
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text("Wrong Credential"),
                //       backgroundColor: Colors.red, // Customize as needed
                //     ),
                //   );
                // }
                setState(() {
                  _isLoading = true;
                });
                String check =
                    await Provider.of<EventListModel>(context, listen: false)
                        .loginJudge(userName.text.trim(), password.text.trim());
                setState(() {
                  _isLoading = false;
                });
                if (check == 'Login successful') {
                  int id = int.parse(idController.text.trim());
                  await _saveJudgeLoginInfo(id);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JudgeEventScreen(
                          judgeId: id,
                        ),
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
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
          ),
          Visibility(
            visible: _isLoading,
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

