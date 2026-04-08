/// Available Gemini models for API requests (REST `models/{id}:generateContent`).
abstract final class GeminiModelCatalog {
  static const String defaultModelId = 'gemini-2.5-flash';

  static const List<GeminiModelOption> models = [
    GeminiModelOption(
      id: 'gemini-2.5-flash',
      label: 'Gemini 2.5 Flash',
    ),
    GeminiModelOption(
      id: 'gemini-3.1-flash-lite-preview',
      label: 'Gemini 3.1 Flash Lite (preview)',
    ),
    GeminiModelOption(
      id: 'gemini-3-flash-preview',
      label: 'Gemini 3 Flash (preview)',
    ),
  ];

  static final Map<String, GeminiModelOption> byId = {
    for (final m in models) m.id: m,
  };

  static String? labelFor(String id) => byId[id]?.label;
}

class GeminiModelOption {
  const GeminiModelOption({
    required this.id,
    required this.label,
  });

  final String id;
  final String label;
}
