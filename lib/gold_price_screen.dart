import 'package:flutter/material.dart';
import 'gold_price_service.dart';

class GoldPriceScreen extends StatefulWidget {
  const GoldPriceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoldPriceScreenState createState() => _GoldPriceScreenState();
}

class _GoldPriceScreenState extends State<GoldPriceScreen> {
  Map<String, double> _goldPrices = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGoldPrices();
  }

  Future<void> fetchGoldPrices() async {
    setState(() {
      _isLoading = true;
    });

    GoldPriceService goldPriceService = GoldPriceService();
    try {
      Map<String, double> goldPrices = await goldPriceService
          .fetchHistoricalGoldPrices(String as String, String as String);
      setState(() {
        _goldPrices = goldPrices;
        _isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: fetchGoldPrices,
                child: ListView.builder(
                  itemCount: _goldPrices.length,
                  itemBuilder: (context, index) {
                    String goldType = _goldPrices.keys.elementAt(index);
                    double? price = _goldPrices[goldType];
                    return ListTile(
                      // ignore: unnecessary_string_interpolations
                      title: Text('$goldType'),
                      subtitle: Text('Price per gram: $price EGP'),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
