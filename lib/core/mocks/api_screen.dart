import 'package:amplify_test/core/models/user.dart';
import 'package:amplify_test/core/services/image_service.dart';
import 'package:amplify_test/core/services/like_service.dart';
import 'package:amplify_test/core/services/post_service.dart';
import 'package:amplify_test/core/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  UserService userService = UserService();
  PostService postService = PostService();
  LikeService likeService = LikeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("api testing")),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                UserModel? user = await userService.getUser("new_user");
                if (user == null) debugPrint("No user");
              },
              child: const Text('Get User Test'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint(dotenv.get("SUPABASE_URL"));
              },
              child: const Text('Check env'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                postService.getPosts();
              },
              child: const Text('Check get posts'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                userService.getPosts();
              },
              child: const Text('Check get users'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                likeService.getLikes(1);
              },
              child: const Text('Check get likes'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                likeService.getLikeCount(1);
              },
              child: const Text('Check get like'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                String? first_name = prefs.getString('first_name');
                debugPrint(first_name);
              },
              child: const Text('Check shared preferences'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                int? userId = prefs.getInt('user_id');
                if(userId == null) return;
                likeService.insertLike(4, userId);
              },
              child: const Text('Check like post'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

               ElevatedButton(
              onPressed: () async {
                ImageService iS = ImageService();
                // iS.getImageSignedUrl("post-images/uploads/2024-07-23T13:32:22.398208.jpg");

              },
              child: const Text('Check like post'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ));
  }
}

