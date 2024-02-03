// lib/crud/list_all_items.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/item.dart';

class ListAllItems extends StatelessWidget {
  const ListAllItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List All Items'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query GetAllItems {
              getAllItems {
                id
                name
                description
              }
            }
          '''),
        ),
        builder: (
          QueryResult result, {
          Future<QueryResult?> Function()? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return Center(
              child: Text('Error: ${result.exception.toString()}'),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Item> items =
              (result.data?['getAllItems'] as List<dynamic>)
                  .map((dynamic itemJson) => Item.fromJson(itemJson))
                  .toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final Item item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/delete',
                      arguments: item.id, // Pass the itemId as an argument
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_update');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
