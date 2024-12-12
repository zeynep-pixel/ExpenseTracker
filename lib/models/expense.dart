
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formater = DateFormat.yMd();

const uuid = Uuid();
enum Categories{
  food, travel, leisure, work
}

const categoryIcons = {
   Categories.food: Icons.lunch_dining,
   Categories.travel: Icons.flight_land,
   Categories.leisure: Icons.movie,
   Categories.work: Icons.work

};

class Expense{
 
 Expense({required this.title, required this.amount,required this.date, required this.category}) : id = uuid.v4() ;

 final String id;
 final String title;
 final double amount;
 final DateTime date;
 final Categories category;


 String get formattedDate{
  return formater.format(date);
 }
  
}