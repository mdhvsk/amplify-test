
import 'package:amplify_test/core/services/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService{

  late SupabaseClient _client;
  bool _isInitialized = false;

  ImageService() {
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    if (!_isInitialized) {
      final instance = await SupabaseClientSingleton.instance;
      _client = instance.client;
      _isInitialized = true;
    }
  }

  Future<String?> getImageSignedUrl(String file) async {
    await _initializeClient();
int slashIndex = file.indexOf('/');
    String bucket = file.substring(0, slashIndex);
    String path = file.substring(slashIndex+1);
  String response = await _client.storage
  .from(bucket)
  .createSignedUrl(path, 3600);
  return response;
  }

}