import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:amplify_test/core/models/user.dart';
import 'supabase_client.dart';

class UserService {
  late SupabaseClient _client;

  UserService() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    final instance = await SupabaseClientSingleton.instance;
    _client = instance.client;

  }

  Future<UserModel?> getUser(String username) async {
    try {
      final response =
          await _client.from('users').select().eq('username', username).single();
      // debugPrint(response.toString());
      // debugPrint(response.runtimeType.toString());
      UserModel model = UserModel.fromJson(response);
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

  Future<UserModel?> getUserById(int userId) async {
    try {
      final response =
          await _client.from('users').select().eq('id', userId).single();
      // debugPrint(response.toString());
      // debugPrint(response.runtimeType.toString());
      UserModel model = UserModel.fromJson(response);
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
  Future<List<UserModel?>?> getPosts() async {
    try {
      await _initializeClient();
      final response = await _client.from('users').select();
      // debugPrint(response.toString());
      // debugPrint(response.runtimeType.toString());
      List<UserModel> models =
          response.map((json) => UserModel.fromJson(json)).toList();
      // debugPrint(models.runtimeType.toString());
      // models.map((model) => debugPrint(model.toString()));
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

  void helloWorld(){

    debugPrint("Its not you its SUPABASE");
  }

  // Other user-related methods...
}
