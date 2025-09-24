import 'package:flutter/material.dart';
import 'package:test_movie/app/resources/app_colors.dart';

class ToastWidget extends StatefulWidget {
  final String text;
  final Color? color;

  const ToastWidget({super.key, required this.text, this.color});

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    invisible();
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: widget.color ?? AppColors.verdigris,
                  ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> invisible() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        visible = false;
      });
    });
  }
}
