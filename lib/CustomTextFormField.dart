import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback ?onTap;
  final ValueChanged<String> ?onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final IconData ? prefixIconData;
final IconData ? suffixIconData;
final String ? hintText;
final bool ? readOnly;
  const CustomTextFormField({super.key,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
     this.onTap,
     this.onFieldSubmitted,
     this.onChanged,
     this.readOnly =  false ,
    required   this.prefixIconData,
     this.suffixIconData,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,

      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
        suffixIcon: suffixIconData != null ? Icon(suffixIconData) : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black54,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

