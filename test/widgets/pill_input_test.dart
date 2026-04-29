import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/widgets/pill_input.dart';

void main() {
  testWidgets("validazione pill input", (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            child: PillInput(
              hint: "Email",
              controller: controller,
              validator: (value) {
                if(value == null || !value.contains("@")) {
                  return "Email non valida";
                }
                return null;
              }
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), "TEST");
    await tester.pump();

    Form.of(tester.element(find.byType(TextFormField))).validate();
    await tester.pump();

    expect(find.text("Email non valida"), findsOneWidget);
  });

  testWidgets("pill input interazione utente", (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PillInput(
            hint: "Email",
            controller: controller
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), "test@test.com");
    expect(controller.text, "test@test.com");
  });
}