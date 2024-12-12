import 'package:exoense_tracker/models/expense.dart';
import 'package:exoense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.50),
            margin: Theme.of(context).cardTheme.margin,),
            child: ExpenseItem(expenses[index])));
  }
}
