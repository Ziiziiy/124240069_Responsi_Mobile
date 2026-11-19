// poster.dart -> WIDGET gambar yang dipakai di Home, Favorit, dan Detail.
// Ada loading saat gambar dimuat, dan ikon pengganti kalau gambar gagal.
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Poster extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit; // cover = memenuhi kotak (terpotong), fitWidth = utuh

  const Poster({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // Url kosong -> langsung tampilkan ikon pengganti
    if (url.isEmpty) return _placeholder();

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      // Beberapa server menolak request tanpa User-Agent seperti browser,
      // jadi kita tambahkan (tidak dipakai di web)
      headers: kIsWeb
          ? null
          : const {
              'User-Agent':
                  'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 '
                      '(KHTML, like Gecko) Chrome/120.0 Mobile Safari/537.36',
            },
      // Khusus web: kalau gambar diblokir (CORS), pakai elemen <img> HTML
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      // Tampilan saat gambar masih dimuat
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height ?? 200,
          color: kCard,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: kOrange),
          ),
        );
      },
      // Tampilan saat gambar gagal dimuat (penyebabnya dicetak di Debug Console)
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Gagal memuat gambar: $url\n$error');
        return _placeholder();
      },
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height ?? 200,
      color: kCard,
      child: const Icon(Icons.movie, color: Colors.grey),
    );
  }
}
