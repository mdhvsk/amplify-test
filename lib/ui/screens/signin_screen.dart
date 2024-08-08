import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_test/core/models/user.dart';
import 'package:amplify_test/core/services/user_service.dart';
import 'package:amplify_test/ui/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserService userService = UserService();
  String? _signInError;

  void _handleLogin(BuildContext context, String username) async {
    UserModel? user = await userService.getUser(username);
    debugPrint(user.toString());
    if (user == null) {
      setState(() {
        _signInError = "Invalid username/password";
      });
      debugPrint("No user found by the username" + username);
      return;
    }
    ;
    _storeUserData(user);
    _login(context);
  }

  Future<void> _storeUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<void> _storeFirstName(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', userId);
  }

  Future<void> _storeUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', user.firstName);
    await prefs.setString('last_name', user.lastName);
    await prefs.setInt('user_id', user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                            SignOutButton(),
            const SizedBox(height: 40),
            Text(
              'UMee News Amplify Test',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            const Text(
              'Username',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            _buildInputField(
                controller: _usernameController,
                label: 'Username',
                maxLines: 1,
                password: false,
                error: _signInError),
            const SizedBox(height: 16),

            const Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            _buildInputField(
                controller: _passwordController,
                label: 'Password',
                maxLines: 1,
                password: true,
                error: _signInError),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _handleLogin(context, _usernameController.text),
              child: const Text('Login to UMee News'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700],
                
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Powered by'),
                  const SizedBox(width: 4),
                  Text(
                    'Mdhvsk Labs',
                    style: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _login(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const FeedScreen()),
    (Route<dynamic> route) => false,
  );
}

Widget _buildInputField(
    {required TextEditingController controller,
    required String label,
    required int maxLines,
    required bool password,
    String? error}) {
  return TextFormField(
    controller: controller,
    obscureText: password,
    
    decoration: InputDecoration(
      labelText: label,
      errorText: error,
      alignLabelWithHint: false,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: Colors.white,
      // border: InputBorder.none,
      // prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textAlignVertical: TextAlignVertical.center,
    maxLines: maxLines,
  );
}
