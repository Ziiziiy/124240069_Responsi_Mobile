import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anime_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/poster.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AnimeController controller = Get.find<AnimeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SEARCH BAR
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
          child: TextField(
            onChanged: (value) => controller.query.value = value,
            decoration: InputDecoration(
              hintText: 'Cari anime...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: kCard,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // DAFTAR ANIME
        Expanded(
          child: Obx(() {
            // 1. Loading
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: kOrange),
              );
            }

            // 2. Gagal memuat
            if (controller.isError.value) {
              return Center(
                child: ElevatedButton(
                  onPressed: controller.fetchAnimes,
                  child: const Text('Gagal memuat. Coba lagi'),
                ),
              );
            }

            // 3. Berhasil 
            final list = controller.filtered;

            if (list.isEmpty) {
              return const Center(child: Text('Anime tidak ditemukan'));
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6, 
              ),
              itemBuilder: (context, index) {
                final anime = list[index];

                return GestureDetector(
                  onTap: () => Get.to(() => DetailPage(id: anime.id)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: kCard,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Poster mengisi ruang yang tersisa
                          Expanded(
                            child: Poster(
                              url: anime.poster,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 2. Nama anime
                                Text(
                                  anime.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                // 3. Rating umur + jumlah episode
                                Text(
                                  '${anime.ageRating} • ${anime.episodeText}',
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // 4. Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 13),
                                    const SizedBox(width: 3),
                                    Text(
                                      anime.ratingText,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}