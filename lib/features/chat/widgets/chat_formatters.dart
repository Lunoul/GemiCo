/// Formats [t] as `dd.MM HH:mm` for the session list subtitle.
String formatChatUpdated(DateTime t) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(t.day)}.${two(t.month)} ${two(t.hour)}:${two(t.minute)}';
}
