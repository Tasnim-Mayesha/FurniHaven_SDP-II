import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/circular_icon.dart';

class AddRemoveButton extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;

  const AddRemoveButton({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onRemove,
          child: CircularIcon(
            icon: Iconsax.minus,
            size: 16,
            backgroundColor: Colors.grey.shade300,
            width: 32,
            height: 32,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 32,
          alignment: Alignment.center,
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: onAdd,
          child: const CircularIcon(
            icon: Iconsax.add,
            size: 16,
            backgroundColor: Colors.deepOrange,
            width: 32,
            height: 32,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
