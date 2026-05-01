import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:travel_together/widgets/code_input6.dart';

void main() {
  testWidgets("renders 6 text fields", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CodeInput6(onCompleted: print),
        ),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(6));
  });

  testWidgets("completamento codice", (tester) async {
    String? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CodeInput6(onCompleted: (code) => result = code),
        ),
      ),
    );

    final fields = find.byType(TextField);
    for(int i = 0; i < 6; i++) {
      await tester.enterText(fields.at(i), '$i');
    }
    await tester.pump();
    expect(result, '012345');
  });

  testWidgets('chiamata onCompleted', (tester) async {
    String? result;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CodeInput6(
            onCompleted: (code) => result = code,
          ),
        ),
      ),
    );

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), '1');
    await tester.pump();
    expect(result, isNull);

    for (int i = 1; i < 6; i++) {
      await tester.enterText(fields.at(i), '$i');
    }
    await tester.pump();
    expect(result, '112345');
  });
}