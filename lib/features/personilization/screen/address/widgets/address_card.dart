import 'package:flutter/material.dart';
import 'package:sdp2/utils/global_colors.dart';

class AddressCard extends StatelessWidget {
  final Map<String, String> address;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
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
          onPressed: () {
            _confirmDeletion(context);
          },
        ),
        onTap: onSelect,
      ),
    );
  }

  void _confirmDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this address and phone number?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
