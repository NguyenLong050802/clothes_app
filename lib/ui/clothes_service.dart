import '../models/view_models.dart';
import 'package:flutter/material.dart';
import '../models/clothes.dart';

class AddClothes extends StatefulWidget {
  const AddClothes({super.key});

  @override
  State<AddClothes> createState() => _AddClothesState();
}

class _AddClothesState extends State<AddClothes> {
  final formKey = GlobalKey<FormState>();
  final viewModel = ClothesViewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController idController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thêm mới'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  viewModel.addClothes(Clothes(
                    id: idController.text,
                    name: nameController.text,
                    price: double.parse(priceController.text),
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập id sản phẩm';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 22),
                    labelText: 'Id :',
                  ),
                ),
                TextFormField(
                    controller: nameController,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Vui lòng nhập tên sản phẩm';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 22),
                      labelText: 'Tên sản phẩm :',
                    )),
                TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giá tiền';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 22),
                    labelText: 'Giá tiền :',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ClothesUpdate extends StatefulWidget {
  final double? price;
  const ClothesUpdate({super.key, this.price});

  @override
  State<ClothesUpdate> createState() => _ClothesUpdateState();
}

class _ClothesUpdateState extends State<ClothesUpdate> {
  late TextEditingController _priceController;
  @override
  void initState() {
    _priceController = TextEditingController(text: widget.price?.toString());
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(double.parse(_priceController.text));
              },
            ),
          ],
        ),
        body: TextField(
          controller: _priceController,
          decoration: const InputDecoration(
            labelText: 'Giá tiền :',
          ),
          keyboardType: TextInputType.number,
        ));
  }
}
