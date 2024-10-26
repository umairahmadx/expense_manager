import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteItem;

  const TransactionList(this._transactions, this._deleteItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "No Expense Found",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: constraints.maxHeight*0.02),
                SizedBox(
                  height: constraints.maxHeight*0.4,
                  child: Image.asset(
                    'assets/images/notFound.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: FittedBox(
                        child: Text("${_transactions[index].amount}"),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: IconButton(
                      onPressed: () => _deleteItem(_transactions[index].id),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      )),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
