import 'package:clothes_store/src/firabase_service.dart';
import 'package:flutter/material.dart';
import 'clothes.dart';

class ClothesViewModel extends ChangeNotifier {
  static final _clothesViewModel = ClothesViewModel._internal();
  factory ClothesViewModel() => _clothesViewModel;
  ClothesViewModel._internal() {
    firebaseService.loadClothesFromFb().then((value) {
      if (value is List<Clothes>) {
        clothesList.clear();
        clothesList.addAll(value);
        notifyListeners();
      }
    });
  }
  final firebaseService = FirebaseService();
  final List<Clothes> clothesList = [];
  Future addClothes(Clothes clothes) async {
    clothesList.add(clothes);
    notifyListeners();

    firebaseService.addClothesTofb(clothes);
    return clothes;
  }

  Future removeClothes(Clothes clothes) async{
    clothesList.remove(clothes);
    notifyListeners();
    firebaseService.deleteClothesTofb(clothes);
  }

  Future updateClothes(Clothes clothes, double price) async {
    try {
      clothes.price.value = price;
      notifyListeners();
      await firebaseService.updateClothesTofb(clothes);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
