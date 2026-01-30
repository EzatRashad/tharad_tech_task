import 'package:flutter/material.dart';
import 'package:tharad_tech/core/utils/utils.dart';

class ErrorBaner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorBaner({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off, size: 50, color: Colors.red),
          12.ph,
          Text(message, textAlign: TextAlign.center),
          16.ph,
          IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
