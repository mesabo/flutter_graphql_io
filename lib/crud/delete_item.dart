// lib/crud/delete_item.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DeleteItem extends StatelessWidget {
  final String itemId;

  const DeleteItem({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Item'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql('''
      mutation {
        deleteItem(id: "$itemId") {
          id
          name
          description
        }
      }
    '''),
        ),
        builder: (
          RunMutation runMutation,
          QueryResult? result,
        ) {
          if (kDebugMode) {
            print(result);
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Are you sure you want to delete this item?',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      runMutation({
                        'itemId': itemId,
                      });
                    },
                    child: const Text('Delete Item'),
                  ),
                  if (result != null && result.hasException)
                    Text('Error: ${result.exception.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
