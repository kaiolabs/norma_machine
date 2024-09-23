import 'package:norma_machine/src/modules/home/models/register.dart';

class InstructionInterpreter {
  Future<int> interpret(
    String instruction,
    int currentInstruction,
    List<Register> registers,
    List<String> executionLog,
  ) async {
    if (instruction.startsWith('add')) {
      return _handleAdd(instruction, currentInstruction, registers, executionLog);
    } else if (instruction.startsWith('sub')) {
      return _handleSub(instruction, currentInstruction, registers, executionLog);
    } else if (instruction.startsWith('if_zero')) {
      return _handleIfZero(instruction, currentInstruction, registers, executionLog);
    } else if (instruction.startsWith('goto')) {
      return _handleGoto(instruction, executionLog);
    } else if (instruction == 'end') {
      executionLog.add('Programa finalizado');
      return currentInstruction + 1;
    } else {
      executionLog.add('Instrução inválida, pulando');
      return currentInstruction + 1;
    }
  }

  int _handleAdd(String instruction, int currentInstruction, List<Register> registers, List<String> executionLog) {
    final registerName = instruction.split('(')[1].split(')')[0];
    final register = registers.firstWhere((r) => r.name == registerName);
    register.value++;
    executionLog.add('  $registerName: ${register.value}');
    return currentInstruction + 1;
  }

  int _handleSub(String instruction, int currentInstruction, List<Register> registers, List<String> executionLog) {
    final registerName = instruction.split('(')[1].split(')')[0];
    final register = registers.firstWhere((r) => r.name == registerName);
    if (register.value > 0) {
      register.value--;
    }
    executionLog.add('  $registerName: ${register.value}');
    return currentInstruction + 1;
  }

  int _handleIfZero(String instruction, int currentInstruction, List<Register> registers, List<String> executionLog) {
    final parts = instruction.split(' ');
    final registerName = parts[0].split('(')[1].split(')')[0];
    final jumpTo = int.parse(parts[2]);
    final register = registers.firstWhere((r) => r.name == registerName);

    if (register.value == 0) {
      executionLog.add('  Condição: Verdadeira');
      return jumpTo - 1;
    } else {
      executionLog.add('  Condição: Falsa');
      return currentInstruction + 1;
    }
  }

  int _handleGoto(String instruction, List<String> executionLog) {
    final jumpTo = int.parse(instruction.split(' ')[1]);
    executionLog.add('  Pulando para a instrução $jumpTo');
    return jumpTo - 1;
  }
}
