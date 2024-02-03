// lib/widgets/item_list.dart
import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;

  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final Item item = items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
        );
      },
    );
  }
}
