import 'package:flutter/services.dart';

class CreditCardNumber extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newSelection = newValue.selection;
    var newText = newValue.text;
    var oldText = oldValue.text;
    bool isAdding = oldText.length < newText.length;

    /// 余白削除後のTEXT
    String deletedSpaceNewText = newText.replaceAll(RegExp('\\s'), "");

    /// 4文字入力された時点で、空欄を設ける
    String text = '';
    for (var i = 0; i < deletedSpaceNewText.length; i++) {
      text = text + deletedSpaceNewText[i];
      int index = i + 1;
      if (index % 4 == 0) text = '$text ';
    }

    /// OffSetを更新
    int offset = newSelection.baseOffset;
    if (isAdding && newSelection.baseOffset == text.length - 1) {
      offset = text.length;
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
