
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:starter/core/constants/app_endpoints.dart';

class GraphQLService {
  static final HttpLink httpLink = HttpLink(
    Endpoints.baseUrl.value,
  );

  // Function to get the token
  static String getAuthToken() {
    // Return the token as a string
    const token = '';
    // appPrint("Bearer ${token??''}");
    return token??''; // Replace with actual token retrieval logic
  }

  static final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer ${getAuthToken()}',
  );

  static Link link = authLink.concat(httpLink);

  static final ValueNotifier<GraphQLClient> _client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    ),
  );

  static ValueNotifier<GraphQLClient> get client => _client;


  static void updateHeaders(Map<String, String> extraHeaders) {
    final updatedHttpLink = HttpLink(
      Endpoints.baseUrl.value,
      defaultHeaders: {
        'Authorization': 'Bearer ${getAuthToken()}',
        ...extraHeaders,
      },
    );

    link = authLink.concat(updatedHttpLink);

    _client.value = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }


  GraphQLService._();

  factory GraphQLService() {
    return GraphQLService._();
  }
}

