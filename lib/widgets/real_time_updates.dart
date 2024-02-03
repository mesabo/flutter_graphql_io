// lib/crud/real_time_updates.dart
// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../api/graphql_client.dart';
import '../models/item.dart';

class RealTimeUpdates extends StatefulWidget {
  const RealTimeUpdates({super.key});

  @override
  _RealTimeUpdatesState createState() => _RealTimeUpdatesState();
}

class _RealTimeUpdatesState extends State<RealTimeUpdates> {
  late final StreamSubscription<QueryResult> _subscription;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _subscription = GraphQLClientConfig.client.subscribe(
      SubscriptionOptions(
        document: gql('''
          subscription ItemUpdates {
            itemUpdates {
              id
              name
              description
            }
          }
        '''),
      ),
    ).listen((QueryResult result) {
      if (!result.hasException) {
        final List<Item> updatedItems = (result.data?['itemUpdates'] as List<dynamic>)
            .map((dynamic itemJson) => Item.fromJson(itemJson))
            .toList();
        setState(() {
          items = updatedItems;
        });
      } else {
        if (kDebugMode) {
          print('Subscription error: ${result.exception.toString()}');
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Updates'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final Item item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
          );
        },
      ),
    );
  }
}
