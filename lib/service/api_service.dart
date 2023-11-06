import 'package:dio/dio.dart';
import 'package:flutter_openai_app/model/openai_response_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<OpenAiResponseModel> getRecommendations({
    required String prompt,
  }) async {
    try {
      final Uri url = Uri.parse('https://api.openai.com/v1/completions');

      final Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      };

      final Map<String, dynamic> requestBody = {
        "model": "gpt-3.5-turbo-instruct",
        "prompt": prompt,
        "max_tokens": 60,
        "temperature": 0.4,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      };

      final Response response = await _dio.postUri(
        url,
        data: requestBody,
        options: Options(
          headers: headers,
        ),
      );

      return OpenAiResponseModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }
}
