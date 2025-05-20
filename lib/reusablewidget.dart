import 'package:flutter/material.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({
    super.key,
    required this.icon,
    required this.text,
    required this.val,
  });
  final IconData icon;
  final String text;
  final double val;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20),
        SizedBox(height: 10),

        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          val.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
