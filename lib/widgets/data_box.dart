import 'package:flutter/material.dart';

class DataBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const DataBox(this.title, {this.subtitle});

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6647B8),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
