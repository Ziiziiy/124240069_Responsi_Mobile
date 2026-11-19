// untuk daftar anime + pencarian
import 'package:get/get.dart';
import '../models/anime.dart';
import '../services/api_service.dart';

class AnimeController extends GetxController {
  final animes = <Anime>[].obs;
  final isLoading = true.obs;
  final isError = false.obs;
  final query = ''.obs;

  List<Anime> get filtered {
    final q = query.value.toLowerCase();
    if (q.isEmpty) return animes;
    return animes.where((a) => a.title.toLowerCase().contains(q)).toList();
  }

  @override
  void onInit() {
    fetchAnimes();
    super.onInit();
  }

  Future<void> fetchAnimes() async {
    isLoading.value = true;
    isError.value = false;
    try {
      animes.assignAll(await getAnimes());
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
  }
}