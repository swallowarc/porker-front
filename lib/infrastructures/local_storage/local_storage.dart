import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _sharedPreferences;

  Future<void> _getInstance() async {
    if (_sharedPreferences != null) {
      return;
    }
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> putMap(String key, Map<String, dynamic> param) async {
    await _getInstance();
    final json = jsonEncode(param);
    _sharedPreferences!.setString(key, json);
  }

  Future<void> putList(String key, List<dynamic> param) async {
    await _getInstance();
    final json = jsonEncode(param);
    _sharedPreferences!.setString(key, json);
  }

  Future<Map<String, dynamic>> getMap(String key) async {
    await _getInstance();
    final json = _sharedPreferences!.get(key);
    if (json == null) {
      return new Map<String, dynamic>();
    }
    return jsonDecode(json.toString());
  }

  Future<List> getList(String key) async {
    await _getInstance();
    final json = _sharedPreferences!.get(key);
    if (json == null) {
      return [];
    }
    return jsonDecode(json.toString());
  }

  Future<void> delete(String key) async {
    await _getInstance();
    await _sharedPreferences!.remove(key);
  }
}
