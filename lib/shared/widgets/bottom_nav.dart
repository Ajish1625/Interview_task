import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final VoidCallback? onTap;

  const BottomNav({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people, color: Colors.deepPurple),
              SizedBox(height: 4),
              Text(
                'Users',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
