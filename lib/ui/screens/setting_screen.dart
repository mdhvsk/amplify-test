import 'package:amplify_test/core/services/user_service.dart';
import 'package:amplify_test/core/models/user.dart';
import 'package:amplify_test/core/services/user_service.dart';
import 'package:amplify_test/ui/screens/signin_screen.dart';
import 'package:amplify_test/ui/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserService userService = UserService();
  late UserModel _user;
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    if (userId == null) return null;
    UserModel? retrievedUser = await userService.getUserById(userId);
    if (retrievedUser == null) return null;
    setState(() {
      _user = retrievedUser;
    });
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('first_name');
    await prefs.remove('last_name');
    await prefs.remove('user_id');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SigninScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Umee Settings",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(247, 247, 247, 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Text(
                "Hey " + _user.firstName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),

            Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                  ),
                  onPressed: () => _logout(context),
                  child: const Text('Sign Out'),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(selectedIndex: 2),
      extendBody: true,
    );
  }
}
