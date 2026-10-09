import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:parfum_app/main.dart';

void main() {
  testWidgets('Parfum Store app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Memastikan judul katalog parfum muncul di layar
    expect(find.text('Katalog Parfum Store'), findsOneWidget);
  });
}
