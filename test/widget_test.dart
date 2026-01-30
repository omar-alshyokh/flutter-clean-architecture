import 'package:flutter_clean_architecture/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app entrypoint exists', () {
    expect(app.main, isNotNull);
  });
}
