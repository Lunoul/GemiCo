/// Strips dangerous HTML from chat markdown before parsing.
///
/// Fenced ``` code ``` blocks are preserved verbatim so examples with `<` stay intact.
/// Outside code: script/iframes are removed and remaining angle-bracket tags are stripped
/// (Flutter markdown still parses [HtmlBlockSyntax] from standard blocks).
String sanitizeChatMarkdownInput(String input) {
  if (input.isEmpty) return input;
  final segments = input.split('```');
  final out = StringBuffer();
  for (var i = 0; i < segments.length; i++) {
    if (i.isEven) {
      out.write(_sanitizePlainMarkdownSegment(segments[i]));
    } else {
      out.write('```');
      out.write(segments[i]);
      out.write('```');
    }
  }
  return out.toString();
}

String _sanitizePlainMarkdownSegment(String s) {
  if (s.isEmpty) return s;
  var x = s;
  x = x.replaceAll(
    RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false),
    '',
  );
  x = x.replaceAll(
    RegExp(r'<iframe[^>]*>[\s\S]*?</iframe>', caseSensitive: false),
    '',
  );
  x = x.replaceAll(RegExp(r'<iframe[^>]*/>', caseSensitive: false), '');
  x = x.replaceAll(
    RegExp(r'<object[^>]*>[\s\S]*?</object>', caseSensitive: false),
    '',
  );
  x = x.replaceAll(RegExp(r'<embed[^>]*/?>', caseSensitive: false), '');
  x = x.replaceAll(RegExp(r'<[^>\n]+>'), '');
  return x;
}
