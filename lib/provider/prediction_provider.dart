import 'package:flutter/material.dart';
import 'package:flutter_openai_app/model/openai_response_model.dart';
import 'package:flutter_openai_app/service/api_service.dart';
import 'package:intl/intl.dart';

class PredictionProvider extends ChangeNotifier {
  final ApiService service = ApiService();

  final currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'IDR',
    decimalDigits: 0,
  );
  final currencyUSD = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'USD',
    decimalDigits: 0,
  );

  final currencyzmb = NumberFormat.currency(
    locale: 'id_ZMB',
    symbol: 'ZMB',
    decimalDigits: 0,
  );

  OpenAiResponseModel? openAiResponse;

  Future<void> getRecommendations({
    required int budget,
    required String manufacturerRegion,
  }) async {
    try {
      final carBudget = currency.format(budget);

      debugPrint(manufacturerRegion);
      debugPrint(carBudget);

      final String prompt =
          'Jika kamu adalah seorang pakar mobil, berikan saya rekomendasi mobil dari pabrikan ${manufacturerRegion.toLowerCase()} dengan budget sekitar $carBudget';
      // 'You are a car expert, Please, give me a car recommendation from ${manufacturerRegion.toLowerCase()} manufacturers with budget equals to $carBudget';

      openAiResponse = await service.getRecommendations(
        prompt: prompt,
      );
      notifyListeners();
    } catch (_) {
      /// Show something
      notifyListeners();
    }
  }
}
