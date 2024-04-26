import 'package:clothes_store/ui/clothes_service.dart';
import 'package:clothes_store/ui/detail_clothes.dart';
import 'package:clothes_store/models/clothes.dart';
import 'package:flutter/material.dart';
import '../models/view_models.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = ClothesViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloths Management'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchClothes(viewModel.clothesList),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddClothes(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: viewModel.clothesList.length,
            itemBuilder: (context, index) {
              final clothes = viewModel.clothesList[index];
              return ListViewClothes(
                key: ValueKey(clothes.id),
                clothes: clothes,
                onTap: () {
                  Navigator.of(context)
                      .push<bool>(
                    MaterialPageRoute(
                      builder: (context) => DetailClothes(clothes: clothes),
                    ),
                  )
                      .then(
                    (value) {
                      if (value == true) {
                        viewModel.removeClothes(clothes);
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            setState(() {
              viewModel.clothesList.sort((a, b) {
                return a.price.value.compareTo(b.price.value);
              });
            });
          } else {
            setState(() {
              viewModel.clothesList.sort((a, b) {
                return b.price.value.compareTo(a.price.value);
              });
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward_rounded),
            label: 'Tăng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward_rounded),
            label: 'Giảm',
          ),
        ],
      ),
    );
  }
}

class ListViewClothes extends StatefulWidget {
  final Clothes clothes;
  final VoidCallback onTap;
  const ListViewClothes(
      {super.key, required this.clothes, required this.onTap});

  @override
  State<ListViewClothes> createState() => _ListViewClothesState();
}

class _ListViewClothesState extends State<ListViewClothes> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.clothes.price,
      builder: ((context, price, child) {
        return ListTile(
          title:
              Text(widget.clothes.name, style: const TextStyle(fontSize: 20)),
          subtitle: Text('Price: $price'),
          onTap: widget.onTap,
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      }),
    );
  }
}

class SearchClothes extends SearchDelegate {
  final List<Clothes> clothesList;
  SearchClothes(this.clothesList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = clothesList.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final clothes = results[index];
        return ListTile(
          title: Text(clothes.name),
          subtitle: Text('Price: ${clothes.price.value}'),
          onTap: () {
            close(context, clothes);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = clothesList.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final clothes = results[index];
        return ListTile(
          title: Text(clothes.name),
          subtitle: Text('Price: ${clothes.price.value}'),
          onTap: () {
            query = clothes.name;
            close(context, clothes);
            Navigator.of(context).push<bool>(
              MaterialPageRoute(
                builder: (context) => DetailClothes(clothes: clothes),
              ),
            );
          },
        );
      },
    );
  }
}
