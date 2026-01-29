import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({
    super.key,
    this.message = 'No data available',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
