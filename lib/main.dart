import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'gold_price_screen.dart';
// ignore: unused_import
import 'news_service.dart';
import 'news_screenn.dart';
import 'currency_exchange_screen.dart';
import 'currency_converter_screen.dart';
// ignore: unused_import
import 'dart:ui';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News, Currency, and Gold Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const NewsScreen(),
    const CurrencyExchangeScreen(),
    const GoldPriceScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Currency Exchange',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.aod), //gold
            label: 'Gold Prices',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CurrencyConverterScreen()),
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.swap_horiz),
        tooltip: 'Currency Converter',
      ),
    );
  }
}

//async operation

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final MyAsyncOperations _asyncOperations = MyAsyncOperations();
  bool _isOperationRunning = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isOperationRunning = !_isOperationRunning;
              if (_isOperationRunning) {
                _asyncOperations.resetOperation();
                _asyncOperations.someAsyncFunction().then((_) {
                  setState(() {
                    _isOperationRunning = false;
                  });
                });
              } else {
                _asyncOperations.cancelOperation();
              }
            });
          },
          child: Text(
              _isOperationRunning ? 'Cancel Operation' : 'Start Operation'),
        ),
      ],
    );
  }
}

//MyAsyncOperations

class MyAsyncOperations {
  bool _canceled = false;

  Future<void> someAsyncFunction() async {
    if (_canceled) {
      return Future<void>.value(); // Return an empty Future<void>
    }

    // Simulate some async operation
    try {
      await Future.delayed(const Duration(seconds: 2));
      // ignore: avoid_print
      print('Async operation completed');
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  void cancelOperation() {
    _canceled = true;
  }

  void resetOperation() {
    _canceled = false;
  }
}
