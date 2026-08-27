import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

void main() {
  testWidgets(
    'Android action sheet keeps cancel action inside bottom safe area',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () {
                PlatformActionSheet().displaySheet(
                  context: context,
                  actions: [
                    ActionSheetAction(text: 'Choose', onPressed: () {}),
                    ActionSheetAction(
                      text: 'Cancel',
                      isCancel: true,
                      onPressed: () {},
                    ),
                  ],
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final safeArea = find.ancestor(
        of: find.text('Cancel'),
        matching: find.byWidgetPredicate(
          (widget) => widget is SafeArea && !widget.top && widget.bottom,
        ),
      );
      expect(safeArea, findsOneWidget);
    },
  );
}
