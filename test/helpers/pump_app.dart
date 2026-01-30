import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

typedef PageBuilder = Widget Function(BuildContext);

Widget buildRouterTestApp({
  required BlocBase<dynamic> bloc,
  required Widget child,
  required List<RouteBase> routes,
  String initialLocation = '/',
}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: routes,
  );

  return BlocProvider.value(
    value: bloc,
    child: MaterialApp.router(routerConfig: router),
  );
}
