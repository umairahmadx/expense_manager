import 'package:expense_manager/widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        fontFamily: 'Baloo Bhai 2',
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            primary: Colors.purple,
            secondary: Colors.yellowAccent),
        appBarTheme: const AppBarTheme(
          color: Colors.purple,
          titleTextStyle: TextStyle(
            fontFamily: 'Baloo Bhai 2', // Using offline font
            fontSize: 24, // Custom font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // Text color
          ),
        ),
        primaryTextTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.purple),
            foregroundColor: Colors.purple,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String txTitle, double txAmt, DateTime setDate) {
    final data = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmt,
      date: setDate,
    );
    setState(() {
      _transactions.add(data);
    });
  }

  void bottomAddTransScreen(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

    List<Transaction> get _recentTransactions {
    return _transactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _deleteItemsList(String id) {
    setState(() {
      _transactions.removeWhere((idx) => idx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context);
    AppBar appBar;
    final isLandscape =
        mediaQuery.size.height < mediaQuery.size.width;
    if (!isLandscape) {
      appBar = AppBar(
        title: const Text(
          'Expense Manager',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      appBar = AppBar(
        title: const Text(
          'Expense Manager',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_sharp),
                  SizedBox(
                    width: 4,
                  ),
                  Text("Charts"),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_rupee_rounded),
                  SizedBox(
                    width: 4,
                  ),
                  Text("Expenses"),
                ],
              ),
            ),
          ],
        ),
      );
    }
    double usableScreenSize = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    return isLandscape
        ? DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              appBar: appBar,
              body: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 6, right: 6),
                  child: Column(
                    children: [
                      SizedBox(
                          height: (usableScreenSize * 0.8) - 36,
                          child: Chart(_recentTransactions)),
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "Expense Graphs",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "All Transactions",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Center(
                            child: SizedBox(
                              height: usableScreenSize - 30,
                              child: TransactionList(
                                  _transactions, _deleteItemsList),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, right: 10),
                            child: FloatingActionButton(
                              onPressed: () => bottomAddTransScreen(context),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ))
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: usableScreenSize * 0.2,
                      child: Chart(_recentTransactions)),
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          "Expense Graphs",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: usableScreenSize * 0.8 - 30,
                      child: TransactionList(_transactions, _deleteItemsList))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => bottomAddTransScreen(context),
              child: const Icon(Icons.add),
            ),
          );
  }
}
