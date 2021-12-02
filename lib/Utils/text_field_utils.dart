import 'package:flutter/material.dart';

void placeCursor(int pos, TextEditingController controller) {
  try {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: pos),
    );
  } catch (e) {
    throw Exception("code_editor : placeCursor(int pos), pos is not valid.");
  }
}

/// Set the cursor at the end of the editableText.
void placeCursorAtTheEnd(TextEditingController controller) {
  controller.selection = TextSelection.fromPosition(
    TextPosition(offset: controller.text.length),
  );
}
