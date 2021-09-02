import 'package:flutter/foundation.dart'; // Diperlukan untuk transaction

class Transaction {
  final String id;
  final String tittle;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id, 
    @required this.tittle, 
    @required this.amount, 
    @required this.date,
  });
}
