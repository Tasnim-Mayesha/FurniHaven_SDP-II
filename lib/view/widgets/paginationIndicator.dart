import 'package:flutter/material.dart';

class PaginationIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  PaginationIndicator({super.key,
    required this.totalPages,
    required this.currentPage,
  }) {
    // TODO: implement PaginationIndicator
    // throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Colors.deepOrange : Colors.grey,
          ),
        );
      }),
    );

  }
}
