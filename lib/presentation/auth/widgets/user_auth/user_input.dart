import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final TextEditingController contr;
  const UserInput({super.key, required this.contr});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contr,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
