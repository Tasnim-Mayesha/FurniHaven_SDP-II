import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class AddressCard extends StatelessWidget {
  final Map<String, String> address;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDelete;

  const AddressCard({super.key, 
    required this.address,
    required this.isSelected,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? GlobalColors.mainColor : Colors.transparent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: ListTile(
        title: Text(address['name']!),
        subtitle: Text('${address['address']}\n${address['phone']}'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
        onTap: onSelect,
      ),
    );
  }
}
