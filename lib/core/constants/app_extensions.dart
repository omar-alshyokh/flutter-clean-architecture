import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// ============================= Strings Extension =============================
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  Color getColorFromHex() {
    String hexColor = toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  bool get itHasValue {
    return isNotEmpty == true;
  }

  bool get isDate {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  String get getSlashedDate {
    final expiryDate = DateTime.parse(this);
    final formatter = DateFormat('d/MM/yy');
    final formatted = formatter.format(expiryDate);
    return formatted;
  }

  bool get  isNumeric {
    return int.tryParse(this) != null;
  }
}

/// ============================= Nullable Strings Extension =============================

extension NullableStringExtension on String? {
  bool get itHasValue {
    return this != null && this?.isNotEmpty == true;
  }
}

/// ============================= Nullable int Extension =============================

extension IntExtension on int? {
  bool get itHasValue {
    return this != null && this != 0;
  }
}

/// ============================= Color Extension =============================
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension DateTimeX on DateTime? {

  String get getTime {
    try {
      if (this != null) {
        return DateFormat('hh:mm a').format(this!);
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
