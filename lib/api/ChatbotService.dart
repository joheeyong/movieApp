import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  final String apiKey;
  final String firstPrompt;
  final String systemPrompt;
  final double temperature;
  final int maxTokens;
  final String model;

  ChatbotService({
    required this.apiKey,
    required this.firstPrompt,
    required this.systemPrompt,
    this.temperature = 0.7,
    this.maxTokens = 8000, // Default max tokens
    this.model = 'gpt-4o', // Default model
  });

  Stream<String> streamMessages(String message) async* {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final userContent = message;

    final body = userContent != ""
        ? jsonEncode({
            'model': "gpt-4o",
            'messages': [
              {
                'role': 'user',
                'content': userContent,
              },
              {'role': 'system', 'content': systemPrompt},
            ],
            'temperature': temperature,
            'max_tokens': maxTokens,
            'stream': true,
          })
        : jsonEncode({
            'model': "gpt-4o",
            'messages': [
              {'role': 'system', 'content': firstPrompt},
            ],
            'temperature': temperature,
            'max_tokens': maxTokens,
            'stream': true,
          });

    final request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..body = body;

    try {
      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        String buffer = '';

        await for (var chunk in streamedResponse.stream) {
          final chunkString = utf8.decode(chunk);
          final lines = chunkString.split('\n');

          for (var line in lines) {
            if (line.isNotEmpty && line.startsWith('data: ')) {
              final jsonLine = line.substring(6);
              if (jsonLine == '[DONE]') {
                yield buffer;
                return;
              }

              try {
                final parsed = jsonDecode(jsonLine);
                if (parsed['choices'] != null && parsed['choices'].isNotEmpty) {
                  final content = parsed['choices'][0]['delta']['content'] ?? '';

                  buffer += content;

                  if (content.contains('\n')) {
                    yield buffer;
                    buffer = '';
                  }
                }
              } catch (e) {
                throw Exception('Streaming error: ${e.toString()}');
              }
            }
          }
        }
      } else {
        throw Exception('Error: ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Streaming error: ${e.toString()}');
    }
  }
}
