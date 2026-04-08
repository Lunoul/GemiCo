import 'package:gemico/l10n/app_localizations.dart';

/// User-visible strings for [GeminiService] failures, tied to the current locale.
class GeminiLocalizedErrors {
  GeminiLocalizedErrors({
    required this.errorPrefix,
    required this.networkDetail,
    required this.timeoutMessage,
    required this.geminiEmptyResponse,
    required this.geminiApiError,
    required this.httpError,
    required this.apiKeyMissing,
  });

  final String errorPrefix;
  final String networkDetail;
  final String timeoutMessage;
  final String geminiEmptyResponse;
  final String Function(int code, String body) geminiApiError;
  final String Function(String message, String detail) httpError;
  final String apiKeyMissing;

  factory GeminiLocalizedErrors.from(AppLocalizations l10n) {
    return GeminiLocalizedErrors(
      errorPrefix: l10n.errorPrefix,
      networkDetail: l10n.networkErrorDetail,
      timeoutMessage: l10n.timeoutError,
      geminiEmptyResponse: l10n.geminiEmptyResponse,
      geminiApiError: (code, body) => l10n.geminiApiError(code, body),
      httpError: (message, detail) => l10n.httpError(message, detail),
      apiKeyMissing: l10n.apiKeyMissing,
    );
  }
}
