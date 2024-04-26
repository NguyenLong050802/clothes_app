import 'package:clothes_store/models/clothes.dart';
import 'package:flutter/material.dart';
import '../models/view_models.dart';
import 'activity.dart';

class DetailClothes extends StatefulWidget {
  const DetailClothes({super.key, required this.clothes});
  final Clothes clothes;

  @override
  State<DetailClothes> createState() => _DetailClothesState();
}

class _DetailClothesState extends State<DetailClothes> {
  final viewModel = ClothesViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clothes.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<double?>(
                context: context,
                builder: (context) =>
                    ClothesUpdate(price: widget.clothes.price.value),
              ).then((value) {
                if (value != null) {
                  viewModel.updateClothes(widget.clothes, value);
                }
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác nhận xóa'),
                    content: const Text(
                        'Bạn có chắc chắn muốn xóa sản phẩm này không?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Xóa'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Quay lại'),
                      ),
                    ],
                  );
                },
              ).then(
                (value) {
                  if (value == true) {
                    Navigator.of(context).pop(true);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<double?>(
        valueListenable: widget.clothes.price,
        builder: (_, price, __) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.clothes.id),
                  Text(widget.clothes.name),
                  Text(widget.clothes.price.value.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
