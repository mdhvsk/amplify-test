// lib/services/supabase_client.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import './supabase_config.dart';

class SupabaseClientSingleton {
  static SupabaseClientSingleton? _instance;
  late SupabaseClient _client;

  SupabaseClientSingleton._();

  static Future<SupabaseClientSingleton> get instance async {
    if (_instance == null) {
      _instance = SupabaseClientSingleton._();
      await _instance!._initialize();
    }

    return _instance!;
  }

  Future<void> _initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
      debug: true 
    );
    _client = Supabase.instance.client;
  }

  SupabaseClient get client => _client;
}