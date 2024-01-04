import 'package:daresto/common/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Test ExpandableText widget', (WidgetTester tester) async {
    // Build the ExpandableText widget.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ExpandableText(
            text: 'This is a long text that should be truncated when not expanded.',
            maxLines: 1,
          ),
        ),
      ),
    );

    // Verify that the 'Show More Description' button is present.
    expect(find.text('Show More Description'), findsOneWidget);

    // Simulate a tap on the 'Show More Description' button.
    await tester.tap(find.text('Show More Description'));
    await tester.pumpAndSettle();

    // Verify that the 'Show More Description' button is no longer present.
    expect(find.text('Show More Description'), findsNothing);
  });
}
