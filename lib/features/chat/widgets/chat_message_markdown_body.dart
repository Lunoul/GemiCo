import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gemico/core/markdown/chat_markdown_sanitizer.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

/// GitHub-flavored markdown without inline HTML parsing (tags are stripped upstream).
final md.ExtensionSet _safeChatExtensionSet = md.ExtensionSet(
  md.ExtensionSet.gitHubFlavored.blockSyntaxes,
  md.ExtensionSet.gitHubFlavored.inlineSyntaxes
      .where((s) => s is! md.InlineHtmlSyntax)
      .toList(),
);

/// Renders chat text as markdown (**bold**, lists, `code`, links) with safe link/image handling.
class ChatMessageMarkdownBody extends StatelessWidget {
  const ChatMessageMarkdownBody({
    super.key,
    required this.text,
    required this.textColor,
  });

  final String text;
  final Color textColor;

  static const double _fontSize = 15.2;
  static const double _lineHeight = 1.35;

  /// System emoji fonts so glyphs render on Android (avoids tofu with custom styles).
  static const List<String> _emojiFallback = [
    'Noto Color Emoji',
    'Segoe UI Emoji',
    'Apple Color Emoji',
  ];

  void _onTapLink(String linkText, String? href, String title) {
    if (href == null || href.isEmpty) return;
    final uri = Uri.tryParse(href.trim());
    if (uri == null) return;
    if (uri.scheme != 'http' && uri.scheme != 'https') return;
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _sizedImageBuilder(MarkdownImageConfig config) {
    final uri = config.uri;
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return const SizedBox.shrink();
    }
    final maxW = min(config.width ?? 280.0, 280.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        uri.toString(),
        width: maxW,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.loading,
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => Text(
          config.alt ?? '[image]',
          style: TextStyle(
            fontSize: 12,
            color: textColor.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = sanitizeChatMarkdownInput(text);
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    final linkColor = const Color(0xFF8EB8FF);
    final codeBg = textColor.withValues(alpha: 0.12);

    final sheet = MarkdownStyleSheet(
      p: TextStyle(
        color: textColor,
        fontSize: _fontSize,
        height: _lineHeight,
        fontFamilyFallback: _emojiFallback,
      ),
      h1: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: _lineHeight,
        fontFamilyFallback: _emojiFallback,
      ),
      h2: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: _lineHeight,
        fontFamilyFallback: _emojiFallback,
      ),
      h3: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: _lineHeight,
        fontFamilyFallback: _emojiFallback,
      ),
      strong: TextStyle(
        color: textColor,
        fontSize: _fontSize,
        height: _lineHeight,
        fontWeight: FontWeight.w600,
        fontFamilyFallback: _emojiFallback,
      ),
      em: TextStyle(
        color: textColor,
        fontSize: _fontSize,
        height: _lineHeight,
        fontStyle: FontStyle.italic,
        fontFamilyFallback: _emojiFallback,
      ),
      code: TextStyle(
        color: textColor,
        fontSize: 14,
        height: 1.35,
        fontFamily: 'monospace',
        fontFamilyFallback: _emojiFallback,
        backgroundColor: codeBg,
      ),
      blockquote: TextStyle(
        color: textColor.withValues(alpha: 0.9),
        fontSize: _fontSize,
        height: _lineHeight,
        fontFamilyFallback: _emojiFallback,
      ),
      blockSpacing: 8,
      listIndent: 20,
      a: TextStyle(
        color: linkColor,
        fontSize: _fontSize,
        height: _lineHeight,
        decoration: TextDecoration.underline,
        fontFamilyFallback: _emojiFallback,
      ),
    );

    return MarkdownBody(
      data: data,
      selectable: true,
      shrinkWrap: true,
      fitContent: true,
      extensionSet: _safeChatExtensionSet,
      styleSheet: sheet,
      onTapLink: _onTapLink,
      sizedImageBuilder: _sizedImageBuilder,
    );
  }
}
