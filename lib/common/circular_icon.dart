import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  final double? width, height, size;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CircularIcon({
    super.key,
    this.width,
    this.height,
    this.size,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor, // Set the background color
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
