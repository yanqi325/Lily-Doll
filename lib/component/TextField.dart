import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final String hintText;
  final bool? obscure;
  final IconData? icon;
  final VoidCallback? onIconPressed;

  LabeledTextField({
    required this.label,
    this.value,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.obscure= false,
    this.icon,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kTextFieldLabelStyle,
        ),
        TextField(
          obscureText: obscure!,
          keyboardType: TextInputType.emailAddress,
          onChanged: onChanged,
          decoration: kTextFieldDecoration.copyWith(
              hintText: hintText,
            suffixIcon: icon != null ? GestureDetector(
              onTap: onIconPressed,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0), // Adjust the spacing as needed
                child: Icon(icon, size: 20, color: Colors.grey), // Adjust the color as needed
              ),
            ): null,
          ),
        ),
      ],
    );
  }
}