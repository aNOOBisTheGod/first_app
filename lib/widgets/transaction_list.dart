import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../models/transaction.dart';
import '../models/themes.dart' as themes;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themes.appTheme[themes.themeCounter],
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: TextStyle(
                      color: themes.appTheme[themes.themeCounter + 2]),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: themes.appTheme[themes.themeCounter],
                  shadowColor: themes.appTheme[themes.themeCounter + 2],
                  elevation: 20,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '₽${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: TextStyle(
                            color: themes.appTheme[themes.themeCounter + 2])),
                    subtitle: Text(
                        formatDate(
                            DateTime(
                                transactions[index].date.year,
                                transactions[index].date.month,
                                transactions[index].date.day),
                            [dd, '/', mm, '/', yyyy]),
                        style: TextStyle(
                            color: themes.appTheme[themes.themeCounter + 2])),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
