import 'package:flutter/material.dart';
// import 'package:localstore/localstore.dart';

class Clothes {
  String id;
  String name;
  ValueNotifier<double> price;
  String? image;
  String? description;
  Clothes({
    required this.id,
    required this.name,
    required double price,
    this.image,
    this.description,
  }) : price = ValueNotifier(price);

  factory Clothes.fromMap(Map<String, dynamic> map) {
    return Clothes(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price.value,
      'image': image,
      'description': description,
    };
  }
}

class ClothesViewModel extends ChangeNotifier {
  static final _clothesViewModel = ClothesViewModel._();
  factory ClothesViewModel() => _clothesViewModel;
  ClothesViewModel._();
  final List<Clothes> clothesList = [];
  void addClothes(Clothes clothes) {
    clothesList.add(clothes);
    notifyListeners();
  }

  void removeClothes(Clothes clothes) {
    clothesList.remove(clothes);
    notifyListeners();
  }

  void updateClothes(Clothes clothes, double price) {
    clothes.price.value = price;
    notifyListeners();
  }

  // Future<void> saveClothes(Clothes clothes) async {
  //   return await Localstore.instance
  //       .collection('clothes')
  //       .doc('clothes')
  //       .set(clothes.toMap());
  // }

  // Future<void> loadClothes() async {
  //   await Localstore.instance.collection('clothes').doc('clothes').get();
  //   notifyListeners();
  // }

  // Future<void> deleteClothes(Clothes clothes) async {
  //   clothesList.remove(clothes);
  //   notifyListeners();
  // }
}
