import 'package:flutter_clean_architecture/app/config/environment.dart';

class AppConfig {
  final Environment env;
  final String baseUrl;
  final String mapsKey;
  final String recaptchaKey;
  final List<String> spkiPins;

  const AppConfig({
    required this.env,
    required this.baseUrl,
    required this.mapsKey,
    required this.recaptchaKey,
    required this.spkiPins,
  });

  factory AppConfig.fromDefines({required Environment env}) {
    const baseUrl = String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://jsonplaceholder.typicode.com',
    );

    const mapsKey = String.fromEnvironment('MAPS_KEY', defaultValue: '');
    const recaptchaKey = String.fromEnvironment('RECAPTCHA_KEY', defaultValue: '');

    const pin1 = String.fromEnvironment('PIN_SPKI_1', defaultValue: '');
    const pin2 = String.fromEnvironment('PIN_SPKI_2', defaultValue: '');

    final pins = <String>[
      if (pin1.isNotEmpty) pin1,
      if (pin2.isNotEmpty) pin2,
    ];

    return AppConfig(
      env: env,
      baseUrl: baseUrl,
      mapsKey: mapsKey,
      recaptchaKey: recaptchaKey,
      spkiPins: pins,
    );
  }

  bool get isDev => env == Environment.dev;
  bool get isStaging => env == Environment.staging;
  bool get isProd => env == Environment.prod;
}
