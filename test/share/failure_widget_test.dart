import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_movie/app/resources/app_colors.dart';
import 'package:test_movie/share/failure_widget.dart';

void main() {
  testWidgets('FailureWidget displays failure text', (WidgetTester tester) async {
    const testMessage = 'Error Happened!';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FailureWidget(failure: testMessage),
        ),
      ),
    );

    expect(find.text(testMessage), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text(testMessage));
    expect(textWidget.style?.color, AppColors.red);
  });
}
