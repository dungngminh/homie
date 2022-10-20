import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
      onPressed: onPressed,
      child: child,
    );
  }
}
