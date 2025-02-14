import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  const ElevatedContainer({super.key, required this.child, this.gradient});
  final Widget child;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          gradient: gradient,
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
