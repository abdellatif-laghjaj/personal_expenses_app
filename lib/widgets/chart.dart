import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transations;

  Chart(this.transations);

  get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < transations.length; i++) {
        if (transations[i].date.day == weekDay.day &&
            transations[i].date.month == weekDay.month &&
            transations[i].date.year == weekDay.year) {
          totalSum += transations[i].amount;
        }
      }
      return totalSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(18),
      child: Row(
        children: [],
      ),
    );
  }
}
