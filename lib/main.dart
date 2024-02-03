import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'crud/create_update_item.dart';
import 'crud/delete_item.dart';
import 'crud/list_all_items.dart';
import 'widgets/real_time_updates.dart';

void main() {
  final HttpLink httpLink = HttpLink(
      'http://localhost:4000/graphql'); // Replace with your GraphQL server URL

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );

  runApp(
    GraphQLProvider(
      client: client,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GraphQL CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => const ListAllItems(),
        '/create_update': (context) => CreateUpdateItem(),
        '/real_time_updates': (context) => const RealTimeUpdates(),
      },
      onGenerateRoute: (settings) {
        // Handle the '/delete' route with itemId as an argument
        if (settings.name == '/delete') {
          final String itemId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => DeleteItem(itemId: itemId),
          );
        }
        return null;
      },
      // home: const ListAllItems(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
