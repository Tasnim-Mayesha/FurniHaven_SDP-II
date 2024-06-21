import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/circular_icon.dart';

class AddRemoveButton extends StatelessWidget {
  const AddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          size: 16,
          backgroundColor: Colors.grey.shade300,
          width: 32,
          height: 32,
          color: Colors.black,
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 32,  // Match the height of CircularIcon
          alignment: Alignment.center,  // Center the text vertically
          child: Text(
            '2',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const CircularIcon(
          icon: Iconsax.add,
          size: 16,
          backgroundColor: Colors.deepOrange,
          width: 32,
          height: 32,
          color: Colors.white,
        ),
      ],
    );
  }
}