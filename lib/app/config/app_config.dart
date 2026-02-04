import 'package:flutter_clean_architecture/app/config/environment.dart';

class AppConfig {
  const AppConfig({
    required this.env,
    required this.baseUrl,
    required this.mapsKey,
    required this.recaptchaKey,
    required this.enableCertificatePinning,
    required this.spkiPinsByHost,
  });

  final Environment env;
  final String baseUrl;
  final String mapsKey;
  final String recaptchaKey;

  /// Final decision used by NetworkModule (pinning ON/OFF).
  final bool enableCertificatePinning;

  /// host -> pinset (base64 pins)
  final Map<String, List<String>> spkiPinsByHost;

  bool get isDev => env == Environment.dev;
  bool get isStaging => env == Environment.staging;
  bool get isProd => env == Environment.prod;

  /// Reads values from --dart-define / --dart-define-from-file
  factory AppConfig.fromDefines() {
    final env = EnvironmentX.from(
      const String.fromEnvironment('ENV', defaultValue: 'dev'),
    );

    const baseUrl = String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://jsonplaceholder.typicode.com',
    );

    const mapsKey = String.fromEnvironment('MAPS_KEY', defaultValue: '');
    const recaptchaKey = String.fromEnvironment('RECAPTCHA_KEY', defaultValue: '');

    // Pinning defines (simple keys, good for JSON define files)
    const host1 = String.fromEnvironment('PIN_HOST_1', defaultValue: '');
    const host1PinA = String.fromEnvironment('PIN_1_A', defaultValue: '');
    const host1PinB = String.fromEnvironment('PIN_1_B', defaultValue: '');

    // Decide if this environment SHOULD use pinning
    final shouldEnablePinning = switch (env) {
      Environment.dev => false,
      Environment.staging => true,
      Environment.prod => true,
    };

    // Build host->pinset map (normalized)
    final pinsByHost = <String, List<String>>{};
    if (shouldEnablePinning) {
      final h = host1.trim().toLowerCase();
      final pins = <String>[
        if (host1PinA.trim().isNotEmpty) host1PinA.trim(),
        if (host1PinB.trim().isNotEmpty) host1PinB.trim(),
      ];

      if (h.isNotEmpty && pins.isNotEmpty) {
        pinsByHost[h] = pins;
      }
    }

    // Final enable flag: only true if env allows + pins exist
    final enableCertificatePinning = shouldEnablePinning && pinsByHost.isNotEmpty;

    return AppConfig(
      env: env,
      baseUrl: baseUrl,
      mapsKey: mapsKey,
      recaptchaKey: recaptchaKey,
      enableCertificatePinning: enableCertificatePinning,
      spkiPinsByHost: pinsByHost,
    );
  }
}
