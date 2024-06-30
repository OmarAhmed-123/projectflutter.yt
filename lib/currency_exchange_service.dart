import 'dart:convert';
import 'package:http/http.dart' as http;

//apikey --> cur_live_mLN5CuimIUkEAVk2FJuI9c6w63Ebd4fEYwCUrixm
class CurrencyExchangeService {
  final String baseUrl =
      'https://api.currencyapi.com/v3/latest?apikey=cur_live_mLN5CuimIUkEAVk2FJuI9c6w63Ebd4fEYwCUrixm';
  final String apiKey =
      'cur_live_mLN5CuimIUkEAVk2FJuI9c6w63Ebd4fEYwCUrixm'; // api key of Currency Exchange
  Future<double> fetchExchangeRate(String base, String target) async {
    final response = await http.get(
      Uri.parse('$baseUrl/latest?base=$base&symbols=$target'),
      headers: {'x-access-token': apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['rates'][target];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  Future<Map<String, double>> fetchHistoricalExchangeRates(
      String base, String target, String startDate, String endDate) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/history?start_at=$startDate&end_at=$endDate&base=$base&symbols=$target'),
      headers: {'x-access-token': apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, double> rates = {};
      data['rates'].forEach((date, rate) {
        rates[date] = rate[target];
      });
      return rates;
    } else {
      throw Exception('Failed to load historical exchange rates');
    }
  }
}
