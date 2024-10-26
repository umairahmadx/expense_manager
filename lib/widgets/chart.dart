import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransaction;

  const Chart(this._recentTransaction, {super.key});

  List<Map<String, Object>> get getTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < _recentTransaction.length; i++) {
        if (_recentTransaction[i].date.day == weekDay.day &&
            _recentTransaction[i].date.month == weekDay.month &&
            _recentTransaction[i].date.year == weekDay.year) {
          totalSum += _recentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return getTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getTransactionValue.map<Widget>((index) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  index['amount'] as double,
                  index['day'] as String,
                  totalSpending == 0.0
                      ? 0.0
                      : (index['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}