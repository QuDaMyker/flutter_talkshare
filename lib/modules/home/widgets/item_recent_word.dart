import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemRecentWord extends StatelessWidget {
  const ItemRecentWord({super.key, required this.vocab});
  final String vocab;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(8),
      child: Text(
        vocab,
        style: const TextStyle(
            color: AppColors.primary40,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
    );;
  }
}