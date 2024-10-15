import 'package:flutter/material.dart';

class CustomClickableCard extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final String? routeName;

  const CustomClickableCard({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: routeName != null
            ? () {
                Navigator.of(context).pushNamed(routeName!);
              }
            : null,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
