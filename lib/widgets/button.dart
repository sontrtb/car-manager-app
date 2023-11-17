import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  final String text;
  final void Function() onPressed;
  bool isLoading;
  bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(13),
          ),
        ),
        child: isLoading == true
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Text(text),
      ),
    );
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  OutlinedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  final String text;
  final void Function() onPressed;
  bool isLoading;
  bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(13),
          ),
        ),
        child: isLoading == true
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Text(text),
      ),
    );
  }
}
