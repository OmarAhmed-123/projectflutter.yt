import 'package:flutter/material.dart';
import 'currency_exchange_service.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyExchangeScreenState createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  Map<String, double> _exchangeRates = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  fetchExchangeRates() async {
    CurrencyExchangeService currencyExchangeService = CurrencyExchangeService();
    Map<String, double> exchangeRates =
        await currencyExchangeService.fetchHistoricalExchangeRates(
            ['EGP', 'EUR', 'GBP'] as String,
            String as String,
            String as String,
            String as String); // Add more currencies as needed
    setState(() {
      _exchangeRates = exchangeRates;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _exchangeRates.length,
                itemBuilder: (context, index) {
                  String currency = _exchangeRates.keys.elementAt(index);
                  return ListTile(
                    title: Text('USD/$currency'),
                    subtitle: Text(_exchangeRates[currency].toString()),
                  );
                },
              ),
      ),
    );
  }
}
