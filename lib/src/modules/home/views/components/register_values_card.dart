import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:norma_machine/src/modules/home/models/register.dart';

class RegisterValuesCard extends StatelessWidget {
  final ValueListenable<List<Register>> registersNotifier;

  const RegisterValuesCard({super.key, required this.registersNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Register>>(
      valueListenable: registersNotifier,
      builder: (context, registers, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Valores dos Registradores:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: registers.length,
                      itemBuilder: (context, index) {
                        final register = registers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                register.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                register.value.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
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
