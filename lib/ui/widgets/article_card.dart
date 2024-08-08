import 'package:amplify_test/core/models/post_card.dart';
import 'package:amplify_test/core/services/like_service.dart';
import 'package:amplify_test/ui/screens/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleCard extends StatefulWidget {
  final PostCardModel model;
  // const ArticleCard({super.key});

  const ArticleCard({super.key, required this.model});

  @override
  State<ArticleCard> createState() => _ArticleCardState(model);
}

class _ArticleCardState extends State<ArticleCard> {
  PostCardModel _model;
  LikeService likeService = LikeService();
  _ArticleCardState(this._model);
  late bool _isLiked;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.model.isLiked;
    _likes = widget.model.likeCount;
  }

  void _viewStory(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ArticleScreen(model: _model)),
    );
  }

  void _handleLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? currentUserId = prefs.getInt('user_id');
    if (currentUserId == null) return;

    if (_isLiked == true) {
      setState(() {
        _isLiked = false;
        _likes--;
        likeService.deleteLike(_model.id, currentUserId);
      });
    } else {
      setState(() {
        _isLiked = true;
        _likes++;
        likeService.insertLike(_model.id, currentUserId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Color.fromRGBO(239, 240, 240, 1),
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
            ),
            title: Text(_model.firstName + " " + _model.lastName),
            subtitle: Text(_model.createdAt.substring(0, 10)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLiked == true) ...[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () => _handleLike(),
                  ),
                ] else ...[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.black,
                    onPressed: () => _handleLike(),
                  ),
                ],

                SizedBox(
                    width: 1), // Add some space between the icon and the number
                Text(
                  _likes.toString(), // Replace with your actual number
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (_model.imageUrl != null) ...[
            GestureDetector(
              onLongPress: () =>
                  _viewStory(context, (widget.key as ValueKey).value),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(_model.imageUrl!,
                    fit: BoxFit.cover, height: 200, width: double.infinity),
              ),
            ),
          ] else ...[
            SizedBox(height: 8),
          ],
          GestureDetector(
            onLongPress: () =>
                _viewStory(context, (widget.key as ValueKey).value),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _model.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
