import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/home/user/user_widget.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/widgets/pill_button.dart';

void main() {
  testWidgets("user widget test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserWidget(user: User.fromJson({
            "id": "asd123",
            "uuid": "asd123",
            "name": "nome utente",
            "email": "test@test.com",
          })),
        ),
      ),
    );

    expect(find.text("nome utente"), findsOneWidget);
    expect(find.byType(PillButton), findsOneWidget);
  });
}