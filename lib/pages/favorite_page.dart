import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/poster.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favorites.isEmpty) {
        return const Center(child: Text('Belum ada anime favorit'));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.favorites.length,
        itemBuilder: (context, index) {
          final anime = controller.favorites[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              dense: true,
              onTap: () => Get.to(() => DetailPage(id: anime.id)),
              // Poster
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Poster(url: anime.poster, width: 40, height: 52),
              ),
              // Nama
              title: Text(
                anime.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
              // Rating
              subtitle: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 13),
                  const SizedBox(width: 3),
                  Text(anime.ratingText, style: const TextStyle(fontSize: 11)),
                ],
              ),
              // Tombol hapus dari favorit
              trailing: IconButton(
                onPressed: () => controller.removeFavorite(anime.id),
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ),
          );
        },
      );
    });
  }
}