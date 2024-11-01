import 'package:flutter/material.dart';
import 'package:money_tracker/model/transactions.dart';

class TransactionProvider extends ChangeNotifier {

  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  double getTotalIncomes(){
    return _transactions
      .where((transaction) => transaction.type == TransactionType.income)
      .map((transaction) => transaction.amount)
      .fold(0, (a, b) => a + b);
  }

  double getTotalExpenses(){
    return _transactions
      .where((transaction) => transaction.type == TransactionType.expense)
      .map((transaction) => transaction.amount)
      .fold(0, (a, b) => a + b);
  }

  double getBalance() {
    return getTotalIncomes() - getTotalExpenses();
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}