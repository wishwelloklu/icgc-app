import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  const ElevatedContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 10,
                color: Color.fromARGB(14, 0, 0, 0))
          ]),
      child: child,
    );
  }
}
