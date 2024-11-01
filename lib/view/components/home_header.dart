import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/controller/transaction_provider.dart';
import 'package:money_tracker/view/widgets/header_card.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String formatToCOP(double amount){
      final format = NumberFormat.currency(locale: 'es_CO', decimalDigits: 0, name: 'COP');
      return format.format(amount);
    }
    
    final textTheme = Theme.of(context).textTheme;
    
    final provider = Provider.of<TransactionProvider>(context);
    final balance = provider.getBalance();
    final incomes = formatToCOP(provider.getTotalIncomes());
    final expenses = formatToCOP(provider.getTotalExpenses());

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text('Money Tracker', 
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900)
          ),
          const SizedBox(height: 12),
          Text('Balance:', 
            style: textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.5)
            ),
          ),
          Text('\$ ${formatToCOP(balance)}', 
            style: textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                HeaderCard(title: 'Incomes', amount: incomes, icon: const Icon(Icons.attach_money, color: Colors.teal)),
                const SizedBox(width: 12,),
                HeaderCard(title: 'Expenses', amount: expenses, icon: const Icon(Icons.money_off, color: Colors.red)),
              ],),
          )
        ],
      )
    );
  }
}

