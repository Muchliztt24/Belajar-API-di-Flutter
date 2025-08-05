import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_api/models/quran_model.dart';

class QuranService {
  static const String _baseUrl = 'https://api.npoint.io/99c279bb173a6e28359c/data';

  static Future<List<QuranModel>> listQuran() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => QuranModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
