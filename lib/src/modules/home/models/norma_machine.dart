import 'dart:async';

import 'package:norma_machine/src/modules/home/models/instruction_interpreter.dart';
import 'package:norma_machine/src/modules/home/models/register.dart';

class NormaMachine {
  final List<Register> _registers = [];
  final List<String> _instructions = [];
  final List<String> _executionLog = [];
  bool _isExecuting = false;
  String _programName = '';

  List<Register> get registers => List.unmodifiable(_registers);
  List<String> get instructions => List.unmodifiable(_instructions);
  List<String> get executionLog => List.unmodifiable(_executionLog);
  bool get isExecuting => _isExecuting;
  String get programName => _programName;

  final InstructionInterpreter _interpreter = InstructionInterpreter();

  void initializeRegisters(int count, List<String> names, List<String> values) {
    _registers.clear();
    for (int i = 0; i < count; i++) {
      _registers.add(Register(
        name: names[i],
        value: int.tryParse(values[i]) ?? 0,
      ));
    }
  }

  Future<void> interpretInstructions(
    List<String> instructions,
    int executionInterval,
    Function() updateCallback,
  ) async {
    _isExecuting = true;
    _executionLog.clear();
    _instructions.clear();
    _instructions.addAll(instructions);

    int currentInstruction = 0;
    final Duration instructionDelay = Duration(seconds: executionInterval);

    while (currentInstruction < _instructions.length && _isExecuting) {
      final instruction = _instructions[currentInstruction].trim();
      _executionLog.add('Executando: $instruction');

      currentInstruction = await _interpreter.interpret(
        instruction,
        currentInstruction,
        _registers,
        _executionLog,
      );

      updateCallback();
      await Future.delayed(instructionDelay);
    }

    if (!_isExecuting) {
      _executionLog.add('Execução interrompida pelo usuário');
    }

    _isExecuting = false;
    updateCallback();
  }

  void stopExecution() {
    _isExecuting = false;
    _executionLog.add('Execução interrompida pelo usuário');
  }

  void loadFromJson(Map<String, dynamic> json) {
    _programName = json['nome'] ?? '';
    _registers.clear();
    json['registradores'].forEach((key, value) {
      _registers.add(Register(name: key, value: int.tryParse(value.toString()) ?? 0));
    });

    _instructions.clear();
    json['programa'].forEach((key, value) {
      _instructions.add(value);
    });
  }

  void clear() {
    _registers.clear();
    _instructions.clear();
    _executionLog.clear();
    _isExecuting = false;
  }
}
