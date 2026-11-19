import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/poster.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController(id), tag: '$id');
    final favoriteC = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail'), centerTitle: false),
      body: Obx(() {
        // Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: kOrange));
        }

        // Gagal memuat
        if (controller.isError.value || controller.anime.value == null) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.fetchAnime,
              child: const Text('Gagal memuat. Coba lagi'),
            ),
          );
        }

        final anime = controller.anime.value!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Poster(
                url: anime.posterBesar,
                width: double.infinity,
                height: 500,
                fit: BoxFit.contain,
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      anime.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // 2. Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 15),
                        const SizedBox(width: 4),
                        Text(
                          anime.ratingText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // 3. Rating umur & jumlah episode
                    Text(
                      '${anime.ageRating} • ${anime.episodeText}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 14),

                    // 5. Tombol Nonton static + 6. tombol favorit
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Popup sederhana di bawah layar
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Selamat menonton'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.play_arrow, size: 16),
                              label: const Text(
                                'Nonton',
                                style: TextStyle(fontSize: 12),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        Obx(() {
                          final sudahFavorit = favoriteC.isFavorite(anime.id);
                          return InkWell(
                            onTap: () => favoriteC.toggleFavorite(anime),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: kCard,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                sudahFavorit
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: sudahFavorit ? Colors.red : Colors.white,
                                size: 20,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // 4. Sinopsis
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      anime.synopsis.isEmpty ? '-' : anime.synopsis,
                      style: const TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
