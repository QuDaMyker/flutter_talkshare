import 'package:flutter/services.dart';

class FixedFirstCharacterFormatter extends TextInputFormatter {
  final String fixedCharacter;

  FixedFirstCharacterFormatter(this.fixedCharacter);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty || newValue.text[0] != fixedCharacter) {
      return oldValue;
    }
    return newValue;
  }
}

class OnlyLettersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp regex = RegExp(r'^[a-zA-Z]*$');
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
