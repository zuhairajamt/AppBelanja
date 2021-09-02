import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import '../models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
        //fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                fontWeight: FontWeight
                    .bold)), // Jadi ini untuk default font diluar appbar

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // String titleInput;
  // String amountInput; Alternatif bisa pakai yang bawah lebih singkat pakai controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   tittle: 'Tahu Tek',
    //   amount: 50100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   tittle: 'Baju',
    //   amount: 100100,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();          // toList agar tidak ada error
  }

  void _addNewTransaction(String txTittle, double txAmount) {
    final newTx = Transaction(
      tittle: txTittle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startaddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false, // set it to false https://stackoverflow.com/questions/51774252/bottom-overloaded-by-213-pixels-in-flutter
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startaddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        // Gunanya agar bisa scroll
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startaddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
