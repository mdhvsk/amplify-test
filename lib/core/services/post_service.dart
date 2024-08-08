import 'package:amplify_test/core/models/post.dart';
import 'package:amplify_test/core/services/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  late SupabaseClient _client;
  bool _isInitialized = false;

  PostService() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    if (!_isInitialized) {
      final instance = await SupabaseClientSingleton.instance;
      _client = instance.client;
      _isInitialized = true;
    }
  }

  Future<PostModel?> getPost(int id) async {
    try {
      final response =
          await _client.from('posts').select().eq('id', id).single();
      // debugPrint(response.toString());
      // debugPrint(response.runtimeType.toString());
      PostModel model = PostModel.fromJson(response);
      // debugPrint(model.runtimeType.toString());

      return model;
    } on PostgrestException catch (error) {
      debugPrint('Error fetching user: ${error.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }

  Future<List<PostModel?>?> getPosts() async {
    try {
      await _initializeClient();
      final response = await _client.from('posts').select().order('created_at', ascending: false);
      List<PostModel> models =
          response.map((json) => PostModel.fromJson(json)).toList();
      return models;
    } on PostgrestException catch (error) {
      debugPrint('Error fetching user: ${error.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }

    // Handle the response
  }

  Future<String?> insertPost(
      int userId, String title, String content, String? imageId) async {
    try {
      await _initializeClient();
      if (imageId == null) {
        final postInfo = {
          "user_id": userId,
          "title": title,
          "content": content,
        };
        final response = await _client.from('posts').insert(postInfo);
        debugPrint('Post w/o image inserted successfully');
      } else {
        final postInfo = {
          "user_id": userId,
          "title": title,
          "content": content,
          "image_id": imageId,
        };
        final response = await _client.from('posts').insert(postInfo);
        debugPrint('Post with image inserted successfully');
      }

    } on PostgrestException catch (error) {
      debugPrint('Error fetching user: ${error.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }
}
