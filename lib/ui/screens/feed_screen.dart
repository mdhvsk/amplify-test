import 'package:amplify_test/core/models/post_card.dart';
import 'package:amplify_test/core/services/like_service.dart';
import 'package:amplify_test/core/services/post_card_service.dart';
import 'package:amplify_test/core/services/post_service.dart';
import 'package:amplify_test/ui/widgets/article_list_widget.dart';
import 'package:amplify_test/ui/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  PostService postService = PostService();
  LikeService likeService = LikeService();
  PostCardService postCardService = PostCardService();
  List<PostCardModel?>? postCardModels = [];
  bool _isFirstLoad = true;
  PostCardModel sample = PostCardModel(
      id: 4,
      userId: 2,
      title: "title",
      content: "content",
      createdAt: "createdAt",
      firstName: "firstName",
      lastName: "lastName",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4nTlqid7uGrRw398W3XpcMWaYptxhdB6r4A&s",
      likeCount: 5,
      isLiked: false);

  @override
  void initState() {
    super.initState();
    debugPrint("Calling initState");
    fetchPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFirstLoad) {
      fetchPosts();
    }
    _isFirstLoad = false;
  }

  Future<void> fetchPosts() async {
    try {
      debugPrint("Fetching posts");
      List<PostCardModel?>? retrievedCards = await postCardService.fetchPosts();
      debugPrint("Retrieved Cards: " + retrievedCards.toString());
      if (retrievedCards != null) {
        setState(() {
          postCardModels = retrievedCards;
          debugPrint(postCardModels.toString());
        });
      }
    } catch (e) {
      debugPrint('Exception when fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Umee News",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(247,247,247, 20),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => fetchPosts(),
              child: Text('Refresh Page'),
              style: ElevatedButton.styleFrom(
                // maximumSize: Size(double.infinity, 50),
                minimumSize: Size(200, 50),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[700],
              ),
            ),
            ArticleListWidget(postCardModels: postCardModels),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(selectedIndex: 0),
      extendBody: true,
    );
  }
}
