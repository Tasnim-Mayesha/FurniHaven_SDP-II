import 'package:flutter/material.dart';

class AddRemoveButton extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;

  const AddRemoveButton({
    required this.onAdd,
    required this.onRemove,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.remove),
        ),
        Text(count.toString()),
        IconButton(
          onPressed: onAdd,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
