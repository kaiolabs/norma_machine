import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExecutionResultCard extends StatelessWidget {
  final ValueListenable<String> resultNotifier;
  final ScrollController resultScrollController;

  const ExecutionResultCard({
    super.key,
    required this.resultNotifier,
    required this.resultScrollController,
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
                    const Text(
                      'Resultado',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
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
