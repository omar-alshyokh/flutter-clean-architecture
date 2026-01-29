import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app/routes/route_paths.dart';
import 'package:flutter_clean_architecture/core/presentation/layout/screen_wrapper.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/app_button.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Starter')),
      body: ScreenWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clean Architecture Starter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Open Posts',
              onPressed: () => context.push(RoutePaths.posts),
            ),
          ],
        ),
      ),
    );
  }
}
