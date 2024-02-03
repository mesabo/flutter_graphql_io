// lib/crud/create_update_item.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../widgets/create_item_form.dart';

class CreateUpdateItem extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  CreateUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create/Update Item'),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql('''
            mutation CreateItem(${'\$'}name: String!, ${'\$'}description: String!) {
              createItem(name: ${'\$'}name, description: ${'\$'}description) {
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
                  CreateItemForm(
                    nameController: nameController,
                    descriptionController: descriptionController,
                    onPressed: () {
                      final String name = nameController.text;
                      final String description = descriptionController.text;

                      runMutation({
                        'name': name,
                        'description': description,
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
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
