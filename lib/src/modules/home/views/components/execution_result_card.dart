import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExecutionResultCard extends StatelessWidget {
  final ValueListenable<String> resultNotifier;
  final ScrollController resultScrollController;
  final VoidCallback onCopyResult;

  const ExecutionResultCard({
    super.key,
    required this.resultNotifier,
    required this.resultScrollController,
    required this.onCopyResult,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: resultNotifier,
      builder: (context, result, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Resultado',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: onCopyResult,
                          tooltip: 'Copiar resultado',
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: resultScrollController,
                        child: Text(
                          result,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
