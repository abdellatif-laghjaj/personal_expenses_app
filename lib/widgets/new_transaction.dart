// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();

  final amountControler = TextEditingController();

  void submitData() {
    final enteredTitle = titleControler.text;
    final enteredAmount = double.parse(amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount);
    //clear the text fields
    titleControler.clear();
    amountControler.clear();
    //close the bottom sheet
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleControler,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountControler,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () => submitData(),
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
