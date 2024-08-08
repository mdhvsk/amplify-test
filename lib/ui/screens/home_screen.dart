import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
      ),
      body: const Center(
        child: Text(
          'Welcome to my Flutter app!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
          print('Floating Action Button pressed!');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// In your main.dart file, you can use this screen as follows:
// 
// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }