
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/core/error/custom_error.dart';
import 'package:starter/core/error/errors.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/core/utils/app_utils.dart';

import 'graphql_service.dart';

@injectable
class GraphQlClientAgent {
  Future<Result> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    try {
      final GraphQLClient client = GraphQLService.client.value;

      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
      );

      final QueryResult result = await client.query(options);
      return handleQueryResult(result);
    } catch (e) {
      return Result(error: const CustomError(message: 'Server Error'));
    }
  }

  Future<Result> performMutation(String mutation,
      {Map<String, dynamic>? variables}) async {
    try {
      final GraphQLClient client = GraphQLService.client.value;

      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables ?? <String, dynamic>{},
      );

      final QueryResult result = await client.mutate(options);

      return handleQueryResult(result);
    } catch (e) {
      appPrint("performMutation catch error: ${e.toString()}");
      return Result(error: const CustomError(message: 'Server Error'));
    }
  }

  Result handleQueryResult(QueryResult result) {
    // Check for exceptions
    if (result.hasException) {
      String errorMessage = 'An error occurred';
      BaseError error = const CustomError();
      if (result.exception?.linkException != null) {
        final linkException = result.exception!.linkException;
        appPrint('linkException $linkException');

        if (linkException is NetworkException) {
          errorMessage =
              'Network error: ${linkException.originalException.toString()}';
          error = CustomError(message: errorMessage);
        } else if (linkException is HttpLinkServerException) {
          final statusCode = linkException.response.statusCode;
          final statusMessage = linkException.response.body;
          errorMessage = 'Server error ($statusCode): $statusMessage';
          error = CustomError(message: errorMessage);
        } else if (linkException is ServerException) {
          appPrint(
              'linkException.originalException ${linkException.originalException}');
          final statusCode = linkException.statusCode;
          // final statusMessage = linkException.response.body;
          errorMessage = 'ServerException';
          error = CustomError(message: errorMessage);
        } else {
          errorMessage = 'Link error: ${linkException.toString()}';
          error = CustomError(message: errorMessage);
        }
      } else if (result.exception?.graphqlErrors != null &&
          result.exception!.graphqlErrors.isNotEmpty) {
        for (var graphqlError in result.exception!.graphqlErrors) {
          // Check for unauthorized error
          if (graphqlError.message.contains('Unauthorized') ||
              (graphqlError.extensions != null &&
                  graphqlError.extensions!['code'] == 'UNAUTHORIZED')) {
            // Handle unauthorized access, e.g., redirect to login
            errorMessage = 'Error: Unauthorized Access';

            error = CustomError(message: errorMessage);
            break;
          } else {
            errorMessage = 'Error: ${graphqlError.message}';

            error = CustomError(message: errorMessage);
            break;
          }
        }
      }
      appPrint(errorMessage);
      return Result(error: error);
    }

    // We receive data
    else if (!result.isLoading) {
      // When the query has completed successfully
      final data = result.data;
      // Process the successful response data
      // appPrint('Query successful, Data: $data');
      return Result(data: data);
    }

    // Additional handling for loading or incomplete state
    else {
      return Result();
    }
  }
}
