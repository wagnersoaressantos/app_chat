import 'package:app_chat/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarHome();
  }

  Future<void> carregarHome() async {
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // analytics.logEvent(name: 'open_app');
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    if (userId == null) {
      var uuid = Uuid();
      userId = uuid.v4();
      prefs.setString("user_id", userId);
    }
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
