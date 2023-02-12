import 'package:flutter/services.dart';

class CreditCardDateOfExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    /// 実装したい機能
    /// 1文字から2文字になった時に' / 'が追加される
    /// 3文字目を削除すると' / 'が削除される
    var newSelection = newValue.selection;
    var newText = newValue.text;
    var oldText = oldValue.text;
    bool isAdding = oldText.length < newText.length;
    print('newText: $newText');
    print('newText length: ${newText.length}');

    String convertDeletedText(String convertText) {
      String deletedText = '';
      for (var i = 0; i < convertText.length; i++) {
        var text = convertText[i];
        if (text != ' ' && text != '/') {
          deletedText = deletedText + text;
        }
      }
      return deletedText;
    }

    /// 空白（ ）と スラッシュ（/）を削除
    /// RegExpでスラッシュを消す方法が分からないからfor文の手動で削除という方針
    String deletedNewText = convertDeletedText(newText);
    String deletedOldText = convertDeletedText(oldText);

    print('deletedNewText: $deletedNewText');

    String value = '';
    for (var i = 0; i < deletedNewText.length; i++) {
      value = value + deletedNewText[i];

      /// 追加：1文字から2文字に増えた時
      if (isAdding && i == 1) {
        value = '$value / ';
      }

      /// 4文字から3文字に削除された時
      if (!isAdding && i == 1 && deletedNewText.length == 3) {
        value = '$value / ';
      }
    }

    print('value: $value');

    /// OffSetを更新
    /// 2文字になった時
    int offset = newSelection.baseOffset;
    if (deletedNewText.length == 2 ||
        (deletedOldText.length == 2 && deletedNewText.length == 3)) {
      offset = value.length;
    }

    return newValue.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
