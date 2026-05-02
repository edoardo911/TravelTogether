import 'package:flutter/material.dart';

class CodeInput6 extends StatefulWidget {
  final Function(String code) onCompleted;

  const CodeInput6({super.key, required this.onCompleted});

  @override
  State<CodeInput6> createState() => _CodeInput6State();
}

class _CodeInput6State extends State<CodeInput6> {
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void _onChanged(int index, String value) {
    if(value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    else if(value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    final code = controllers.map((c) => c.text).join();
    if(code.length == 6) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
            width: 40,
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) => _onChanged(index, value),
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
            ),
          ),
          if(index != 5) const SizedBox(width: 12),
          ],
        );
      }),
    );
  }
}
