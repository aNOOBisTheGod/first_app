import 'package:flutter/material.dart';
import '../models/themes.dart' as themes;

class ChartBar extends StatelessWidget {
  late final String label;
  late final double spendingAmount;
  late final double spendingPtcOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPtcOfTotal);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('₽ ${spendingAmount.toStringAsFixed(0)}',
          style: TextStyle(color: themes.appTheme[themes.themeCounter + 2])),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: spendingPtcOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ))
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        label,
        style: TextStyle(color: themes.appTheme[themes.themeCounter + 2]),
      )
    ]);
  }
}
