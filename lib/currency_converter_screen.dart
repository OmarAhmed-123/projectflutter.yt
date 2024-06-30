import 'package:flutter/material.dart';
import 'currency_exchange_service.dart';
import 'historical_chart.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  late double _exchangeRate;
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = '';
  Map<String, double> _historicalRates = {};

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
    fetchHistoricalRates();
  }

  Future<void> fetchExchangeRate() async {
    CurrencyExchangeService exchangeService = CurrencyExchangeService();
    try {
      double rate = await exchangeService.fetchExchangeRate('USD', 'EGP');
      setState(() {
        _exchangeRate = rate;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> fetchHistoricalRates() async {
    CurrencyExchangeService exchangeService = CurrencyExchangeService();
    try {
      Map<String, double> rates =
          await exchangeService.fetchHistoricalExchangeRates(
              'USD', 'EGP', '2023-01-01', '2023-12-31');
      setState(() {
        _historicalRates = rates;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void _convertCurrency() {
    double amount = double.parse(_amountController.text);
    double converted = amount * _exchangeRate;
    setState(() {
      _convertedAmount = converted.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount in USD'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert to EGP'),
            ),
            const SizedBox(height: 16.0),
            Text(
              // ignore: unnecessary_null_comparison
              _exchangeRate == null
                  ? 'Fetching exchange rate...'
                  : 'Exchange Rate: 1 USD = $_exchangeRate EGP',
            ),
            const SizedBox(height: 16.0),
            Text(
              _convertedAmount.isEmpty
                  ? ''
                  : 'Converted Amount: $_convertedAmount EGP',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32.0),
            _historicalRates.isEmpty
                ? const CircularProgressIndicator()
                : HistoricalChart(
                    data: _historicalRates,
                    title: 'Historical Exchange Rates',
                    color: Colors.blue,
                  ),
          ],
        ),
      ),
    );
  }
}
