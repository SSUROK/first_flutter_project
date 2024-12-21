import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onNext2;

  const BottomButtons({super.key,
    required this.onNext,
    required this.onNext2,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        ElevatedButton(
          onPressed: onNext,
          child: const Text('Перейти на экран 1'),
        ),
        ElevatedButton(
          onPressed: onNext2,
          child: const Text('Перейти на экран 2'),
        ),
      ],
    );
  }
}