import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/core/network/pinning/spki_pin_calculator.dart';

HttpClientAdapter buildPinnedAdapter(AppConfig config) {
  const calculator = SpkiPinCalculator();

  return IOHttpClientAdapter(
    createHttpClient: () {
      // Fail-closed pinning: disable system trust store and only allow pinned certs.
      final context = SecurityContext(withTrustedRoots: false);
      final client = HttpClient(context: context)

      ..badCertificateCallback = (cert, host, port) {
        final normalizedHost = host.toLowerCase().trim();
        final allowedPins =
        config.spkiPinsByHost[normalizedHost]?.map((e) => e.trim()).toList();

        if (kDebugMode) {
          debugPrint('PINNING host=$normalizedHost port=$port');
          debugPrint('PINNING allowedPins=${allowedPins?.length ?? 0}');
        }

        if (allowedPins == null || allowedPins.isEmpty) {
          if (kDebugMode) {
            debugPrint('PINNING BLOCKED: no pins configured for $normalizedHost');
          }
          return false; // strict
        }

        try {
          final serverPin = calculator.calculateBase64Sha256(cert);

          final ok = allowedPins.contains(serverPin);

          if (kDebugMode) {
            debugPrint('PINNING serverPin=$serverPin');
            debugPrint('PINNING match=$ok');
          }

          return ok;
        } on Exception catch (e) {
          if (kDebugMode) {
            debugPrint('PINNING BLOCKED: exception while calculating pin: $e');
          }
          return false;
        }
      };

      return client;
    },
  );
}
