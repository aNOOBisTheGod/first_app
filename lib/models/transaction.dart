class Transaction {
  late String id;
  late String title;
  late double amount;
  late DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

class TransactionFields {
  static final List<String> values = [id, title, amount, time];

  static final String id = '_id';
  static final String number = 'number';
  static final String title = 'title';
  static final String amount = 'amount';
  static final String time = 'time';
}
