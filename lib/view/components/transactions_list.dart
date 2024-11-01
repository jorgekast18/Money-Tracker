import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transaction_provider.dart';
import 'package:money_tracker/model/transactions.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {

            final transaction = transactions[index];
            final type = transaction.type == TransactionType.income ? 'Income' : 'Expense';
            const iconIncome = Icon(
              Icons.attach_money,
              color: Colors.teal,
            );

            const iconExpense = Icon(
              Icons.money_off,
              color: Colors.red,
            );

            final icon = transaction.type == TransactionType.income ? iconIncome : iconExpense;

            final value = transaction.type == TransactionType.expense
              ? '-\$ ${transaction.amount.abs().toStringAsFixed(2)}'
              : '\$ ${transaction.amount.toStringAsFixed(2)}';

            Color colorValue = transaction.type == TransactionType.expense
              ? Colors.red
              : Colors.teal;
            return ListTile(
              leading: icon,
              title: Text(transaction.description),
              subtitle: Text(type),
              trailing: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: colorValue
                ),
              ),
            );
          }
        )
      ),
    );
  }
}