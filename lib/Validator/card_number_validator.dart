// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_nullable, constant_pattern_never_matches_value_type

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberFormattor extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final String newText = newValue.text;
    final String newTextFiltered =
    newText.replaceAll(RegExp(r'[^\d]'), '');

    final int selectionIndexFromRight = newText.length - newValue.selection.end;
    int offset = 0;

    final StringBuffer newTextBuffer = StringBuffer();
    for(int  i = 0; i < newTextFiltered.length; i++) {
      if(i > 0 && i % 4 == 0) {
        newTextBuffer.write('-');
        if(newValue.selection.end >= i + offset) {
          offset++;
        }
      }
      newTextBuffer.write(newTextFiltered[i]);
    }
    return TextEditingValue(
      text: newTextBuffer.toString(),
      selection: TextSelection.collapsed(
          offset: newTextBuffer.length - selectionIndexFromRight),
    );
  }
}

