import 'package:flutter/material.dart';

class Chart_Bars extends StatelessWidget {
  final String label;
  final double amount;
  final double percentFilled;
  Chart_Bars(this.label, this.amount, this.percentFilled);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //constraints contain the information of the widget Chart_Bars
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                  height: constraints.maxHeight * 0.15,
                  child:
                      FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentFilled,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight*0.05,
              ),
              Container(
                height: constraints.maxHeight*0.15 ,
                child: FittedBox(child:Text('$label')),
              )
            ],
          ),
        );
      },
    );
  }
}
