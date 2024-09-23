import 'package:flutter/material.dart';
import 'package:norma_machine/src/core/shared/dialog_pattern.dart';
import 'package:norma_machine/src/core/shared/input_field.dart';
import 'package:norma_machine/src/core/shared/text_pattern.dart';

class DropdownPattern extends StatefulWidget {
  final List<String> items;
  final TextEditingController selectedValue;
  final double width;
  final String label;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  const DropdownPattern({
    super.key,
    required this.items,
    required this.selectedValue,
    this.width = 0.2,
    this.label = '',
    this.validator,
    this.onChanged,
  });
  @override
  State<DropdownPattern> createState() => _DropdownPatternState();
}

class _DropdownPatternState extends State<DropdownPattern> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.width,
      child: InputField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        label: widget.label,
        controller: widget.selectedValue,
        validator: widget.validator,
        suffixIcon: Icons.keyboard_arrow_down_rounded,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        onTap: () {
          DialogPattern.show(
            width: 0.3,
            context: context,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextPattern(
                      text: 'Selecione um status',
                      fontSize: 18,
                    ).bold(),
                  ),
                  ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) => Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pop(context);
                          widget.selectedValue.text = widget.items[index];
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              TextPattern(
                                text: widget.items[index],
                                fontSize: 16,
                              ).medium(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
