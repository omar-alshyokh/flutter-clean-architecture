import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/constants/app_colors.dart';
import 'package:starter/core/constants/app_text_style.dart';
import 'package:starter/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer(3);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.splashBG,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1666),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Starter APP',
                      style: appTextStyle.smallTSBasic.copyWith(
                          color: AppColors.yellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _startSplashScreenTimer(int i) {
    Timer(Duration(seconds: i), () {
      _navigation();
    });
  }
  _navigation() async {
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }
}


