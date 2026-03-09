/*
 * File: auth_text_field.dart
 * Description: Generic bounded text input structure encapsulating localized credential masking securely cleanly independently.
 * Responsibilities: Hides sensitive strings, connects remote validators consistently, formats native device keyboards explicitly, and tracks internal cursor focus effortlessly.
 * Dependencies: None
 * Lifecycle: Created upon arbitrary user credential actions, Disposed rapidly closing forms deeply.
 * Author: Rachata
 * Course: CMU Fondue
 */

import 'package:flutter/material.dart';

/// Unifies primitive text input layers enforcing strict styling bounds checking explicit authentication intents identically securely safely.
class AuthTextField extends StatefulWidget {
  /// The reactive text buffer driving continuous external form logic uniquely strictly.
  final TextEditingController controller;

  /// The brief textual label guiding localized physical input actions completely native explicitly.
  final String label;

  /// The active contextual failure asserting negative form validation backwards gracefully natively.
  final String? errorText;

  /// Whether internal character bounds apply strict star masking intentionally securely distinctly.
  final bool isPassword;

  /// Injects external domain behaviors immediately firing custom logic matching typing natively.
  final ValueChanged<String>? onChanged;

  /// Forces specific device keyboard layouts enforcing correct formatting limits completely smoothly locally.
  final TextInputType? keyboardType;

  /// The layout rule switching localized hardware buttons advancing arbitrary sequences implicitly automatically.
  final TextInputAction? textInputAction;

  /// Initializes a new instance of [AuthTextField].
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword ? _obscureText : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.errorText,
        filled: true,
        fillColor: Colors.white,
        border: _border(const Color(0xFF5D3891)),
        enabledBorder: _border(const Color(0xFF5D3891)),
        focusedBorder: _border(const Color(0xFF5D3891)),
        errorBorder: _border(Colors.red),
        focusedErrorBorder: _border(Colors.red),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
      ),
    );
  }

  /// Projects reusable constraint shapes aligning bounding outlines dynamically consistently across focus scopes perfectly natively.
  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }
}
