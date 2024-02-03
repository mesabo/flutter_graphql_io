// lib/widgets/create_item_form.dart
import 'package:flutter/material.dart';

class CreateItemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function onPressed;

  const CreateItemForm({super.key, 
    required this.nameController,
    required this.descriptionController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: const Text('Create/Update Item'),
        ),
      ],
    );
  }
}
