import 'package:flutter/material.dart';
import '../models/themes.dart' as themes;
import 'package:date_format/date_format.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  final amountController = TextEditingController();

  void sumbit() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    print(enteredAmount);
    print(enteredTitle);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.pink,
              primaryColorDark: Colors.blue,
              accentColor: Colors.teal,
              cardColor: Colors.yellow,
            ),
            dialogBackgroundColor: Colors.grey[350],
          ),
          child: child as Widget,
        );
      },
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        print(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themes.appTheme[themes.themeCounter],
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: themes.appTheme[themes.themeCounter + 2],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: themes.appTheme[themes.themeCounter + 2],
                      width: 5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 3.0),
                ),
              ),
              controller: titleController,
              onSubmitted: (_) => sumbit(),
              style: TextStyle(
                color: themes.appTheme[themes.themeCounter + 2],
              ),
              cursorColor: themes.appTheme[themes.themeCounter + 2],
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              maxLength: 16,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color: themes.appTheme[themes.themeCounter + 2],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: themes.appTheme[themes.themeCounter + 2],
                      width: 5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 3.0),
                ),
              ),
              controller: amountController,
              onSubmitted: (_) => sumbit(),
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: themes.appTheme[themes.themeCounter + 2],
              ),
              cursorColor: themes.appTheme[themes.themeCounter + 2],
              // onChanged: (val) => amountInput = val,
            ),
            Row(
              children: [
                Text(
                  formatDate(
                      DateTime(_selectedDate.year, _selectedDate.month,
                          _selectedDate.day),
                      [dd, '/', mm, '/', yyyy]),
                  style: TextStyle(
                      color: themes.appTheme[themes.themeCounter + 2]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: datePicker,
                  color: Colors.pink,
                  child: Text(
                    'Choose Date',
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.pink,
                  onPressed: sumbit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
