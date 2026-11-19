class Anime {
  final int id;
  final String title; 
  final String poster;
  final String posterBesar; 
  final String cover; 
  final String ageRating; 
  final int? episodeCount; 
  final double? rating;
  final String synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.poster,
    required this.posterBesar,
    required this.cover,
    required this.ageRating,
    required this.episodeCount,
    required this.rating,
    required this.synopsis,
  });

  String get ratingText => rating == null ? '-' : '$rating';
  String get episodeText => '${episodeCount ?? 'N/A'} Episodes';

  factory Anime.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];

    final titles = attr['titles'] ?? {};
    final posterImage = attr['posterImage'] ?? {};
    final coverImage = attr['coverImage'] ?? {}; 

    final String poster = posterImage['small'] ?? posterImage['tiny'] ?? '';

    String https(String url) => url.replaceFirst('http://', 'https://');

    return Anime(
      id: int.parse(json['id'].toString()),
      title: titles['en_jp'] ?? titles['en'] ?? attr['canonicalTitle'] ?? '-',
      poster: https(poster),
      posterBesar: https(posterImage['large'] ?? posterImage['original'] ?? poster),
      cover: https(coverImage['large'] ??
          coverImage['original'] ??
          posterImage['large'] ??
          poster),
      ageRating: attr['ageRating'] ?? '-',
      episodeCount: attr['episodeCount'],
      rating: double.tryParse('${attr['averageRating']}'),
      synopsis: attr['synopsis'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster': poster,
      'posterBesar': posterBesar,
      'cover': cover,
      'ageRating': ageRating,
      'episodeCount': episodeCount,
      'rating': rating,
      'synopsis': synopsis,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map['id'],
      title: map['title'],
      poster: map['poster'],
      posterBesar: map['posterBesar'] ?? map['poster'],
      cover: map['cover'],
      ageRating: map['ageRating'],
      episodeCount: map['episodeCount'],
      rating: map['rating'],
      synopsis: map['synopsis'],
    );
  }
}