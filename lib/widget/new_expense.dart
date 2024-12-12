import 'package:exoense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final formater = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Categories selectedCategory = Categories.leisure;

  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please make sure a valid title, amount, date and category was entered'),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(ctx);}, child: const Text('OKAY'))
                ],
              ));
              return;
    }
    widget.onAddExpense(Expense(title: titleController.text, amount: enteredAmount, date: selectedDate!, category: selectedCategory));
    Navigator.pop(context);

  }


  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints){
      final width = constraints.maxWidth;

      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,48,16, keyBoardSpace + 16),
          child: Column(
            children: [
              if(width >= 600)
               Row(children: [
                Expanded(
                  child: TextField(
                  controller: titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                                ),
                ),
               const SizedBox(width: 24,),
                Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('AMOUNT'),
                      ),
                    ),
                  ),
               ])
              else
              TextField(
                controller: titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),

              if(width>=600)
                Row(children: [
                  DropdownButton(
                      value: selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          selectedCategory = value;
                        });
                      }),
                      const SizedBox(width: 24,),
                      Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedDate == null
                            ? 'No date selected'
                            : formater.format(selectedDate!)),
                        IconButton(
                            onPressed: datePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],)
              else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('AMOUNT'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedDate == null
                            ? 'No date selected'
                            : formater.format(selectedDate!)),
                        IconButton(
                            onPressed: datePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              
              if(width>=600)
               Row(children: [ const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      submitExpenseData();
                    },
                    child: const Text('Save Expense'),
                  )],)
              else
              Row(
                children: [
                  DropdownButton(
                      value: selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          selectedCategory = value;
                        });
                      }),
                      const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      submitExpenseData();
                    },
                    child: const Text('Save Expense'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );});


  }
}
