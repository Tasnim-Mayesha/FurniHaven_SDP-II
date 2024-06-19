import 'package:flutter/material.dart';

class TotalSalesBox extends StatelessWidget {
  const TotalSalesBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Sales'),
          Text(
            '1000',
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}

class TotalProfitBox extends StatelessWidget {
  const TotalProfitBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Profit'),
          Text(
            '300',
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
