import 'package:flutter/material.dart';

class DataBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const DataBox(this.title, {this.subtitle});

  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 100,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF6647B8),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
