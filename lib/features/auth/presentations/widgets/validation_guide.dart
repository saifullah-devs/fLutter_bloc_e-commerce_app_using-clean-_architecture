import 'package:e_commerce_bloc/core/config/color/colors.dart';
import 'package:flutter/material.dart';

class ValidationGuide extends StatelessWidget {
  final List<String> requirements;
  final String title;

  const ValidationGuide({
    super.key,
    required this.requirements,
    this.title = "Requirements:",
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          ...requirements.map((req) => _buildRequirementItem(req)),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 14, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
