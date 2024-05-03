import 'package:clothes_store/models/clothes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Future<void> addClothesTofb(Clothes clothes) async {
    await FirebaseFirestore.instance
        .collection('clothes')
        .doc(clothes.id)
        .set(clothes.toMap());
  }

  Future loadClothesFromFb() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("clothes").get();
    final data = querySnapshot.docs.map((e) {
      final id = e['id'];
      final name = e['name'];
      final price = e['price'];
      return Clothes(
        id: id,
        name: name,
        price: price.toDouble(),
      );
    }).toList();
    if (data.isNotEmpty) {
      return data;
    }
    return null;
  }

  Future deleteClothesTofb(Clothes clothes) async {
    await FirebaseFirestore.instance
        .collection('clothes')
        .doc(clothes.id)
        .delete();
  }

  Future updateClothesTofb(Clothes clothes) async {
    await FirebaseFirestore.instance
        .collection('clothes')
        .doc(clothes.id)
        .update(
      {'price': clothes.price.value},
    );
  }

  Future addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .set(userInfoMap);
  }
}
