import 'package:flutter/material.dart';
import 'package:test_movie/app/resources/app_colors.dart';

class FailureWidget extends StatelessWidget {
  final String failure;
  final Function? retry;

  const FailureWidget({super.key, required this.failure, this.retry});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Center(
          child: Text(
            failure,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.red,
                ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
