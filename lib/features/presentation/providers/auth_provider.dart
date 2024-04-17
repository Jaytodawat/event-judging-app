import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  // SharedPreferences prefs;
  Future<void> saveLoginInfo(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', isAdmin);
    // You can also save other user information if needed
  }

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('isAdmin');
  }

  Future<int> checkJudgeLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.containsKey('isJudgeLoggedIn');

    if (loggedIn) {
      int judgeId = prefs.getInt('judgeId') ?? 0; // Get judge ID
      return judgeId;
    }
    return 0;
  }
  Future<void> saveJudgeLoginInfo(int judgeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isJudgeLoggedIn', true);
    prefs.setInt('judgeId', judgeId); // Save judge ID
  }

  Future<void> clearLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data in SharedPreferences
  }

}