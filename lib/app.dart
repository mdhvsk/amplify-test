import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_test/ui/screens/home_screen.dart';
import 'package:amplify_test/ui/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
          builder: Authenticator.builder(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(247, 247, 247, 20),
          ),
          home: SigninScreen()),
    );
  }
}
