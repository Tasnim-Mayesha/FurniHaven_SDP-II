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
        bool isCurrentPage = index == currentPage;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width:index ==currentPage? 30.0:12.0,
          height:index ==currentPage? 12.0:12.0,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            shape: isCurrentPage ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isCurrentPage ? BorderRadius.circular(5.0) : null,
            color: currentPage == index ? Colors.deepOrange : Colors.grey,
          ),
        );
      }),
    );

  }
}
