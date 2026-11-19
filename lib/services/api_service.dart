import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

// Endpoint daftar anime (20 data pertama)
String apiURL = "https://kitsu.io/api/edge/anime/?page[limit]=20&page[offset]=0";

// Endpoint detail anime 
String detailURL = "https://kitsu.io/api/edge/anime";

// Ambil daftar anime. Respons Kitsu berbentuk Map, list-nya ada di key "data".
Future<List<Anime>> getAnimes() async {
  final response = await http.get(Uri.parse(apiURL));
  if (response.statusCode == 200) {
    final List data = jsonDecode(utf8.decode(response.bodyBytes))['data']; 
    return data.map((item) => Anime.fromJson(item)).toList();
  } else {
    throw Exception('Gagal memuat daftar anime');
  }
}

// Ambil detail 1 anime berdasarkan id 
Future<Anime> getSingleAnime(int id) async {
  final response = await http.get(Uri.parse('$detailURL/$id'));
  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes))['data']; 
    return Anime.fromJson(data);
  } else {
    throw Exception('Gagal memuat detail anime');
  }
}