// ignore_for_file: prefer_const_constructors, must_be_immutable
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        fontFamily: "Poppins",
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: "PoppinsMed",
            fontSize: 20,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
            // ignore: deprecated_member_use
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: "Poppins", fontSize: 20))),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "Memory DDR4",
      amount: 27.84,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Mouse Logitech",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Keyboard K120",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Headphone MSI",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t5",
      title: "Mouse Razer",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t6",
      title: "Keyboard Razer",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t7",
      title: "Headphone Razer",
      amount: 23.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t8",
      title: "Mouse Logitech",
      amount: 23.99,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  //add new transation
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  //show bottom sheet
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape)
              SwitchListTile(
                title: Text('Show Chart'),
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              ),
            // ignore: sized_box_for_whitespace
            if (!_isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape) txListWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
