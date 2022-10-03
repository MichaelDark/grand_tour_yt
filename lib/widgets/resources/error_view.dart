import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final dynamic error;
  final VoidCallback? retry;

  const ErrorView(this.error, {super.key, this.retry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(error.toString()),
            ),
            if (retry != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: retry,
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
