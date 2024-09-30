import 'package:flutter/material.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 64),
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}