// ignore_for_file: prefer_const_constructors

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/img/empty.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 34,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FittedBox(
                      child: Text(
                        "\$${transactions[index].amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.remove_circle_sharp,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () => _deleteTransaction(transactions[index].id),
                ),
              );
            },
          );
  }
}
