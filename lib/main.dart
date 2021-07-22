import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'models/themes.dart' as themes;

void main() {
  runApp(MyApp());
}

class appTheme {
  final List appThemeList = [Colors.white, Colors.black];
  int themeCounter = 0;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.pink,
        fontFamily: 'Quicksand',
      ),
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
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
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
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNew(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void changeTheme() {
    print(themes.themeCounter);
    setState(() {
      themes.themeCounter++;
      themes.themeCounter %= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The App'),
        actions: [
          IconButton(
              onPressed: changeTheme, icon: Icon(Icons.color_lens_outlined))
        ],
      ),
      body: Container(
          color: themes.appTheme[themes.themeCounter],
          child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(_userTransactions, _deleteTransaction)
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNew(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
