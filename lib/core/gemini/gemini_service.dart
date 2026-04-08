import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:gemico/core/gemini/gemini_localized_errors.dart';
import 'package:gemico/features/chat/chat_message.dart';
import 'package:gemico/features/chat/chat_mode.dart';

class GeminiService {
  GeminiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<String> generateReply({
    required String modelId,
    required List<ChatMessage> messages,
    required String userInput,
    required ChatMode mode,
    required String systemInstruction,
    required String apiKey,
    required GeminiLocalizedErrors strings,
  }) async {
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$modelId:generateContent',
    );

    final contents = <Map<String, dynamic>>[
      for (final message in messages)
        {
          'role': message.isUser ? 'user' : 'model',
          'parts': [
            {'text': message.text},
          ],
        },
      {
        'role': 'user',
        'parts': [
          {'text': userInput},
        ],
      },
    ];

    final payload = <String, dynamic>{
      'systemInstruction': {
        'parts': [
          {'text': systemInstruction},
        ],
      },
      'contents': contents,
      'generationConfig': {
        'temperature': mode == ChatMode.plus18 ? 0.95 : 0.7,
        'topP': 0.95,
        'maxOutputTokens': 1024,
      },
    };

    late final http.Response response;
    try {
      response = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': apiKey,
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 120));
    } on SocketException {
      throw Exception(strings.networkDetail);
    } on HttpException catch (e) {
      throw Exception(strings.httpError(e.message, strings.networkDetail));
    } on http.ClientException catch (e) {
      if (_looksLikeDnsOrSocketFailure(e)) {
        throw Exception(strings.networkDetail);
      }
      rethrow;
    } on TimeoutException catch (_) {
      throw Exception(strings.timeoutMessage);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        strings.geminiApiError(response.statusCode, response.body),
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = decoded['candidates'] as List<dynamic>?;
    final first = candidates != null && candidates.isNotEmpty
        ? candidates.first as Map<String, dynamic>
        : null;
    final content = first?['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    final text = parts != null && parts.isNotEmpty
        ? (parts.first as Map<String, dynamic>)['text'] as String?
        : null;

    if (text == null || text.trim().isEmpty) {
      throw Exception(strings.geminiEmptyResponse);
    }

    return text.trim();
  }
}

bool _looksLikeDnsOrSocketFailure(http.ClientException e) {
  final m = e.message;
  return m.contains('host lookup') ||
      m.contains('No address associated') ||
      m.contains('SocketException') ||
      m.contains('Failed host lookup');
}
