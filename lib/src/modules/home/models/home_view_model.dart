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
      "registradores": {"a": 9, "b": 11, "resultado": 0},
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
      "nome": "Contagem Regressiva",
      "registradores": {"contador": 0, "limite": 5},
      "programa": {
        "1": "if_zero(limite) goto 5",
        "2": "add(contador)",
        "3": "sub(limite)",
        "4": "goto 1",
        "5": "end",
      },
    },
    {
      "nome": "Multiplicação de dois números",
      "registradores": {"A": 8, "B": 8, "C": 0, "D": 0},
      "programa": {
        "1": "if_zero(B) goto 12", // Se B == 0, vá para a instrução 12 (fim).
        "2": "sub(B)", // Decrementa B em 1.
        "3": "if_zero(A) goto 7", // Se A == 0, vá para a instrução 7.
        "4": "sub(A)", // Decrementa A.
        "5": "add(D)", // Incrementa D.
        "6": "goto 3", // Volta para a instrução 3.
        "7": "if_zero(D) goto 1", // Se D == 0, vá para a instrução 1 (repetição do ciclo externo).
        "8": "sub(D)", // Decrementa D.
        "9": "add(C)", // Incrementa C (soma ao resultado).
        "10": "add(A)", // Restaura A.
        "11": "goto 7", // Volta para a instrução 7.
        "12": "end" // Fim do programa.
      }
    },
    {
      "nome": "Igualdade de dois números",
      "registradores": {"A": 5, "B": 5, "resultado": 0},
      "programa": {
        "1": "if_zero(A) goto 5",
        "2": "sub(A)",
        "3": "sub(B)",
        "4": "goto 1",
        "5": "if_zero(B) goto 7",
        "6": "goto 8",
        "7": "add(resultado)",
        "8": "end"
      }
    },
    {
      "nome": "Determinação do Maior Número entre Dois (Versão Final e Corrigida)",
      "registradores": {"A": 8, "B": 5, "C": 0, "D": 8, "E": 5},
      "programa": {
        "1": "if_zero(A) goto 6", // Se A == 0, vá para 6 (B maior)
        "2": "if_zero(B) goto 10", // Se B == 0, vá para 10 (A maior)
        "3": "sub(A)", // Decrementa A em 1
        "4": "sub(B)", // Decrementa B em 1
        "5": "goto 1", // Volta para 1
        "6": "if_zero(E) goto 16", // Se E == 0, fim
        "7": "add(C)", // Incrementa C com 1 (copiar E para C)
        "8": "sub(E)", // Decrementa E em 1
        "9": "goto 6", // Continua copiando E para C
        "10": "if_zero(D) goto 16", // Se D == 0, fim
        "11": "add(C)", // Incrementa C com 1 (copiar D para C)
        "12": "sub(D)", // Decrementa D em 1
        "13": "goto 10", // Continua copiando D para C
        "16": "halt" // Fim do programa
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
