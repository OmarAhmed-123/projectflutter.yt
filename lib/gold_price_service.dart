import 'dart:convert';
import 'package:http/http.dart' as http;

class GoldPriceService {
  final String baseUrl = 'https://www.goldapi.io/api/XAU/USD';
  final String apiKey = 'goldapi-3b1724usly10lbaw-io'; // api key of gold

//-H 'x-access-token: goldapi-3b1724usly10lbaw-io'

  Future<Map<String, double>> fetchHistoricalGoldPrices(
      String startDate, String endDate) async {
    final response = await http.get(
      Uri.parse('$baseUrl/xau/usd/history/$startDate/$endDate'),
      headers: {'x-access-token': apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, double> prices = {};
      for (var entry in data) {
        prices[entry['date']] = entry['price'];
      }
      return prices;
    } else {
      throw Exception('Failed to load historical gold prices');
    }
  }
}
