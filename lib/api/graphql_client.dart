// lib/api/graphql_client.dart
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientConfig {
  static final HttpLink httpLink = HttpLink(
    'http://localhost:4000/graphql', // Replace with your GraphQL API endpoint
  );

  static final WebSocketLink webSocketLink = WebSocketLink(
    'ws://localhost:4000',
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  static final Link link = Link.split(
    (request) => request.isSubscription,
    webSocketLink,
    httpLink,
  );

  static final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}
