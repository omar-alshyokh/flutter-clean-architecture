extension StringX on String {
  bool get isBlank => trim().isEmpty;

  String get trimmed => trim();
}

extension NullableStringX on String? {
  String orEmpty() => this ?? '';
}
