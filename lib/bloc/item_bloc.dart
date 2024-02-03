// lib/bloc/item_bloc.dart
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/graphql_client.dart';
import '../models/item.dart';

class ItemBloc {
  final GraphQLClient client = GraphQLClientConfig.client;

  final StreamController<List<Item>> _itemsController = StreamController<List<Item>>();
  Stream<List<Item>> get itemsStream => _itemsController.stream;

  Future<void> fetchItems() async {
    final QueryResult result = await client.query(QueryOptions(
      document: gql('''
        query GetAllItems {
          getAllItems {
            id
            name
            description
          }
        }
      '''),
    ));

    if (!result.hasException) {
      final List<Item> items = (result.data?['getAllItems'] as List<dynamic>)
          .map((dynamic itemJson) => Item.fromJson(itemJson))
          .toList();
      _itemsController.sink.add(items);
    } else {
      throw Exception('Failed to fetch items: ${result.exception.toString()}');
    }
  }

  void dispose() {
    _itemsController.close();
  }
}

final ItemBloc itemBloc = ItemBloc();
