import 'package:flutter/material.dart';
import 'package:norma_machine/src/modules/home/models/norma_machine.dart';
import 'package:norma_machine/src/modules/home/models/register.dart';

class HomeViewModel {
  final TextEditingController memoryRegistersController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerValueController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  final ScrollController resultScrollController = ScrollController();

  final NormaMachine _normaMachine = NormaMachine();

  // Adicionando os ValueNotifier
  final ValueNotifier<List<Register>> registersNotifier = ValueNotifier<List<Register>>([]);
  final ValueNotifier<String> resultNotifier = ValueNotifier<String>('');

  List<Register> get registers => _normaMachine.registers;
  bool get isExecuting => _normaMachine.isExecuting;

  int executionInterval = 0;
  String selectedExample = '';

  final List<Map<String, dynamic>> examples = [
    {
      "nome": "Soma de dois números",
      "registradores": {"a": 5, "b": 3, "resultado": 0},
      "programa": {
        "1": "if_zero(a) goto 5",
        "2": "add(resultado)",
        "3": "sub(a)",
        "4": "goto 1",
        "5": "if_zero(b) goto 9",
        "6": "add(resultado)",
        "7": "sub(b)",
        "8": "goto 5",
        "9": "end"
      }
    },
    {
      "nome": "Contagem",
      "registradores": {"contador": 0, "limite": 5},
      "programa": {
        "1": "if_zero(limite) goto 5",
        "2": "add(contador)",
        "3": "sub(limite)",
        "4": "goto 1",
        "5": "end",
      }
    },
  ];

  void loadExample(String? newValue) {
    if (newValue != null) {
      selectedExample = newValue;
      final example = examples[int.parse(newValue)];
      clearAllFields();
      _normaMachine.loadFromJson(example);
      _updateInputFields();
      _updateNotifiers();
    }
  }

  void clearAllFields() {
    memoryRegistersController.clear();
    registerNameController.clear();
    registerValueController.clear();
    instructionsController.clear();
    resultController.clear();
    _normaMachine.clear();
    _updateNotifiers();
  }

  void _updateInputFields() {
    memoryRegistersController.text = registers.length.toString();
    registerNameController.text = registers.map((r) => r.name).join(',');
    registerValueController.text = registers.map((r) => r.value.toString()).join(',');
    instructionsController.text = _normaMachine.instructions.join('\n');
  }

  Future<void> executeInstructions() async {
    _normaMachine.initializeRegisters(
      int.parse(memoryRegistersController.text),
      registerNameController.text.split(','),
      registerValueController.text.split(','),
    );
    await _normaMachine.interpretInstructions(
      instructionsController.text.split('\n'),
      executionInterval,
      _updateResult,
    );
  }

  void stopExecution() {
    _normaMachine.stopExecution();
    _updateResult();
  }

  void _updateResult() {
    resultController.text = _normaMachine.executionLog.join('\n');
    _updateNotifiers();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resultScrollController.animateTo(
        resultScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _updateNotifiers() {
    resultNotifier.value = resultController.text;
    registersNotifier.value = List.from(_normaMachine.registers);
  }

  void dispose() {
    memoryRegistersController.dispose();
    registerNameController.dispose();
    registerValueController.dispose();
    instructionsController.dispose();
    resultController.dispose();
    resultScrollController.dispose();
    registersNotifier.dispose();
    resultNotifier.dispose();
  }
}
