import 'package:Expenses_App/widgets/chart.dart';
import 'package:Expenses_App/widgets/new_transaction.dart';
import 'package:Expenses_App/widgets/transaction_list.dart';
import 'package:Expenses_App/widgets/user_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Tracker',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans',
                      fontSize: 20,fontWeight: FontWeight.bold))),
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 3000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Groceries',
    //   amount: 2000,
    //   date: DateTime.now(),
    // )
  ];

  void _addNewTransaction(String txTitle, int txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((trxn){
      return trxn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses Tracker',
          // style: TextStyle(fontFamily: 'Open Sans'),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
