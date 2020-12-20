extension StringExt on String {
  /// 改行を取り除く
  ///
  /// CR（U+000D）
  /// LF（U+000A）
  /// 「次の行」（next line）を示すNEL（U+0085）
  /// 行区切り文字（line separator）を示すLS（U+2028）
  /// 段落区切り文字（paragraph separator）を示すPS（U+2029）
  String trimNewline() {
    return this.replaceAll(RegExp(r'[\u000A\u000D\u0085\u2028\u2029]'), '');
  }
}
