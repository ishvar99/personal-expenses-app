import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    // return groupedTransactions.fold(0.0, (sum,val){
    //    return sum+val['amount'];
    // });
    double sum = 0.0;
    groupedTransactions.forEach((item) {
      sum += item['amount'];
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(20),
        // color: Theme.of(context).accentColor,
        elevation: 6,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: groupedTransactions.map((data) {
                  return Flexible(
                      fit: FlexFit.tight,
                      child: Chart_Bars(
                          data['day'],
                          data['amount'],
                          totalSpending == 0
                              ? 0.0
                              : (data['amount'] as double) / totalSpending));
                }).toList()
                //Flexible with fit:flexFit.tight is equivalent to Expanded widget
                )));
  }
}
