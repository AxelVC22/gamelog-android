import 'package:flutter/material.dart';

class AppTextArea extends StatefulWidget {
  final String? hint;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const AppTextArea({
    super.key,
    this.hint,
    this.maxLength = 300,
    this.minLines = 5,
    this.maxLines = 8,
    this.onChanged,
    this.controller,
  });

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        const SizedBox(height: 6),

        TextField(
          controller: controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: "", // ocultamos contador default
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Contador personalizado
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${controller.text.length}/${widget.maxLength}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
