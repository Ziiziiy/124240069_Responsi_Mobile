import 'package:get/get.dart';
import '../models/anime.dart';
import '../services/api_service.dart';

class DetailController extends GetxController {
  final int id; 
  DetailController(this.id);

  final anime = Rxn<Anime>(); 
  final isLoading = true.obs;
  final isError = false.obs;

  @override
  void onInit() {
    fetchAnime();
    super.onInit();
  }

  Future<void> fetchAnime() async {
    isLoading.value = true;
    isError.value = false;
    try {
      anime.value = await getSingleAnime(id);
    } catch (e) {
      isError.value = true;
    }
    isLoading.value = false;
  }
}