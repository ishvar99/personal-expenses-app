import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';                         
import './widgets/transactions_list.dart';
// import 'package:flutter/services.dart';

void main() {
  //We can restrict landscape rotation by using :
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        // buttonColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'Shoes', amount: 69.3, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Grocery', amount: 18.7, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Clothing', amount: 53.0, date: DateTime.now())
  ];
  List get _recentTransactions {
    return _userTransactions.where((txn) {
      //'where' is same as filter
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransactions.add(Transaction(
          title: title,
          amount: amount,
          date: date,
          id: DateTime.now().toString()));
    });
  }

  // void _removeTransaction(int index){
  //   setState(() {
  //    _userTransactions.removeAt(index);
  //   });
  // }
  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  final titleController = TextEditingController();
  final amountConroller = TextEditingController();
  bool _showChart = false;
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape= MediaQuery.of(context).orientation==Orientation.landscape;
    final appbar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        )
      ],
      title: Text('Personal Expenses App'),
    );

    return Scaffold(
        appBar: appbar,
        // SingleChildScrollView(
        //   child:

        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
         if(isLandscape)   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                    
                  },
                ),
              ],
            ),
            if(!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            if(!isLandscape)
             Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionsList(_userTransactions, _removeTransaction)),
            if(isLandscape)
            _showChart?Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Chart(_recentTransactions)):
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionsList(_userTransactions, _removeTransaction)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        ));
  }
}
