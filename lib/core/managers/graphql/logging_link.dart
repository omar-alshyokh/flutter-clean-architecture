// import 'package:catch_operator_hub_app/core/utils/app_utils.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
//
// class LoggerLink extends Link {
//   @override
//   Stream<Response> request(
//     Request request, [
//     NextLink? forward,
//   ]) {
//     Stream<Response> response = forward!(request).map((Response fetchResult) {
//       final ioStreamedResponse =
//           fetchResult.context.entry<HttpLinkResponseContext>();
//       appPrint("Request: $request");
//       appPrint("Response:${ioStreamedResponse?.toString() ?? "null"}");
//
//       return fetchResult;
//     }).handleError((error) {
//       // throw error;
//     });
//
//     return response;
//   }
//
//   LoggerLink();
// }
