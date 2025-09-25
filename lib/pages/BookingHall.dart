import 'package:flutter/material.dart';

class BookingHall extends StatelessWidget {
  const BookingHall({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BookingHall Coming Soon . . .",
            style: TextStyle(color: Colors.grey[400], fontSize: 30),
          ),
        ],
      ),
    );
  }
}
