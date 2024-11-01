import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transaction_provider.dart';
import 'package:money_tracker/model/transactions.dart';
import 'package:provider/provider.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({ super.key });

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {

  int typeIndex = 0;

  TransactionType transactionType = TransactionType.expense;
  double amount = 0;
  String description = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 650,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 48,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3)
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'New transaction',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: typeIndex,
            children: const {
              0: Text('Expense'),
              1: Text('Income'),
            }, 
            onValueChanged: (value) {
              setState(() {
                typeIndex = value!;
                transactionType = value == 0 ? TransactionType.expense : TransactionType.income;
                
              });
            }
          ),
          const SizedBox(height: 20,),
          Text(
            'amount',
            style: textTheme.bodySmall!.copyWith(color: Colors.teal),
          ),
          TextField(
            inputFormatters: [CurrencyTextInputFormatter.currency(
              symbol: '\$',
              decimalDigits: 0
            )],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(hintText: '\$ 0', hintStyle: TextStyle(color: Colors.grey)),
            autofocus: true,
            onChanged: (value){
              final valueClean = value.replaceAll('\$', '').replaceAll(',', '');

              if(valueClean.isNotEmpty){
                amount = double.parse(valueClean);
              }
            },
          ),
          Text(
            'Description',
            style: textTheme.bodySmall!.copyWith(color: Colors.teal),
          ),
          TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration.collapsed(hintText: 'Enter description', hintStyle: TextStyle(color: Colors.grey)),
            onChanged: (value) {
              description = value;
            },
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 200,
            child: ElevatedButton(            
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: (){

                Transaction transaction = Transaction(
                  type: transactionType, 
                  amount: amount, 
                  description: description
                );
                Provider.of<TransactionProvider>(context, listen: false)
                  .addTransaction(transaction);

                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              )
            ),
          )
        ],
      ),
    );
  }
}