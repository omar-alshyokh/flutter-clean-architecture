import 'dart:convert';
import 'dart:io' as io;

import 'package:crypto/crypto.dart';
import 'package:x509/x509.dart' as x509;

class SpkiPinCalculator {
  const SpkiPinCalculator();

  String calculateBase64Sha256(io.X509Certificate cert) {
    final objects = x509.parsePem(cert.pem);
    final parsed = objects.whereType<x509.X509Certificate>().first;

    final spki = parsed.tbsCertificate.subjectPublicKeyInfo;
    if (spki == null) {
      throw StateError('subjectPublicKeyInfo is null');
    }

    final spkiDer = spki.toAsn1().encodedBytes;
    final digest = sha256.convert(spkiDer).bytes;
    return base64.encode(digest);
  }
}
