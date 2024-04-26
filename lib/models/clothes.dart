import 'package:flutter/material.dart';

class Clothes {
  String id;
  String name;
  ValueNotifier<double> price;
  String? image;
  String? description;
  Clothes({
    required double price,
    required this.id,
    required this.name,
    this.image,
    this.description,
  }) : price = ValueNotifier(price);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price.value,
      'image': image,
      'description': description,
    };
  }

  factory Clothes.fromMap(Map<String, dynamic> map) {
    return Clothes(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      image: map['image'] != null ? map['image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Clothes(id: $id, name: $name, price: $price, image: $image, description: $description)';
  }
}


