import 'package:flutter/material.dart';
import '../services/history_service.dart';
 // Подключаем сервис истории

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'RUB'];

  void _convert() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      setState(() {
        _result = 'Введите корректную сумму';
      });
      return;
    }

    // Временный курс обмена (пока фиксирован)
    double rate = 1.1;
    double converted = amount * rate;

    setState(() {
      _result = '$amount $_fromCurrency = ${converted.toStringAsFixed(2)} $_toCurrency';
    });

    // Только если пользователь авторизован!
    HistoryService().addConversion(_fromCurrency, _toCurrency, amount, converted);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    items: _currencies.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _fromCurrency = val);
                    },
                    decoration: const InputDecoration(labelText: 'Из валюты'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toCurrency,
                    items: _currencies.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _toCurrency = val);
                    },
                    decoration: const InputDecoration(labelText: 'В валюту'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Конвертировать'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
