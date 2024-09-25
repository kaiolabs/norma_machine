import 'package:flutter/material.dart';
import 'package:norma_machine/src/core/shared/button_pattern.dart';
import 'package:norma_machine/src/core/shared/input_field_pattern.dart';
import 'package:norma_machine/src/core/shared/page_state.dart';
import 'package:norma_machine/src/modules/home/controller/home_controller.dart';
import 'package:norma_machine/src/modules/home/models/home_view_model.dart';
import 'package:norma_machine/src/modules/home/views/components/execution_result_card.dart';
import 'package:norma_machine/src/modules/home/views/components/register_values_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends PageState<HomeView, HomeController> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Norma Machine'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIntervalDropdown(),
              _buildExampleSelector(),
              _buildClearButton(),
              _buildLoadFileButton(), // Adiciona o botão de carregar arquivo
              _buildInputFields(),
              RegisterValuesCard(
                registersNotifier: _viewModel.registersNotifier,
              ),
              ExecutionResultCard(
                resultNotifier: _viewModel.resultNotifier,
                resultScrollController: _viewModel.resultScrollController,
                onCopyResult: () {
                  _viewModel.copyResultToClipboard();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Resultado copiado para a área de transferência')),
                  );
                },
              ),
              _buildStopButton(),
              _buildExecuteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntervalDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownButtonFormField<int>(
        decoration: const InputDecoration(
          labelText: 'Intervalo de execução (segundos)',
          border: OutlineInputBorder(),
        ),
        value: _viewModel.executionInterval,
        onChanged: (int? newValue) {
          setState(() {
            _viewModel.executionInterval = newValue!;
          });
        },
        items: List.generate(11, (index) => index).map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value == 0 ? 'Sem intervalo' : value.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExampleSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Selecione um exemplo',
          border: OutlineInputBorder(),
        ),
        value: _viewModel.selectedExample.isEmpty ? null : _viewModel.selectedExample,
        onChanged: (String? newValue) {
          setState(() {
            _viewModel.loadExample(newValue);
          });
        },
        items: _viewModel.examples.asMap().entries.map<DropdownMenuItem<String>>((entry) {
          return DropdownMenuItem<String>(
            value: entry.key.toString(),
            child: Text(entry.value['nome']),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildClearButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: ButtonPattern(
        onPressed: () {
          _viewModel.clearAllFields();
          setState(() {});
        },
        label: 'Limpar tudo e reiniciar',
      ),
    );
  }

  Widget _buildLoadFileButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ButtonPattern(
        onPressed: () async {
          bool permissionGranted = await _viewModel.loadFile();
          if (!permissionGranted) {
            _showPermissionDialog();
          }
          setState(() {});
        },
        label: 'Carregar arquivo',
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissão necessária'),
          content: const Text('Permissão para acessar arquivos foi negada. Por favor, conceda permissão nas configurações do aplicativo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Abrir Configurações'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        InputFieldPattern(
          controller: _viewModel.programNameController,
          label: 'Nome do Programa',
        ),
        InputFieldPattern(
          controller: _viewModel.memoryRegistersController,
          label: 'Quantidade de registros de memória',
        ),
        InputFieldPattern(
          controller: _viewModel.registerNameController,
          label: 'Nome do registro',
        ),
        InputFieldPattern(
          controller: _viewModel.registerValueController,
          label: 'Valor do registro',
        ),
        InputFieldPattern(
          controller: _viewModel.instructionsController,
          label: 'Instruções',
          keyboardType: TextInputType.multiline,
          multiline: true,
        ),
      ],
    );
  }

  Widget _buildExecuteButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ButtonPattern(
        onPressed: _viewModel.isExecuting
            ? null
            : () async {
                setState(() {});
                await _viewModel.executeInstructions();
                setState(() {});
              },
        label: 'Executar instruções',
      ),
    );
  }

  Widget _buildStopButton() {
    return Visibility(
      visible: _viewModel.isExecuting,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ButtonPattern(
          onPressed: () {
            _viewModel.stopExecution();
            setState(() {});
          },
          label: 'Parar execução',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
